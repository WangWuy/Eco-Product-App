import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import * as request from 'supertest';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { AppModule } from 'src/app.module';

describe('ProductsController (e2e)', () => {
    let app: INestApplication;
    let authToken: string;

    beforeAll(async () => {
        const moduleFixture: TestingModule = await Test.createTestingModule({
            imports: [
                ConfigModule.forRoot({
                    isGlobal: true,
                }),
                TypeOrmModule.forRootAsync({
                    imports: [ConfigModule],
                    useFactory: (configService: ConfigService) => ({
                        type: 'mysql',
                        host: configService.get('TEST_DB_HOST'),
                        port: configService.get('TEST_DB_PORT'),
                        username: configService.get('TEST_DB_USERNAME'),
                        password: configService.get('TEST_DB_PASSWORD'),
                        database: configService.get('TEST_DB_NAME'),
                        entities: [__dirname + '/../**/*.entity{.ts,.js}'],
                        synchronize: true,
                    }),
                    inject: [ConfigService],
                }),
                AppModule,
            ],
        }).compile();

        app = moduleFixture.createNestApplication();
        app.useGlobalPipes(new ValidationPipe({
            whitelist: true,
            transform: true,
        }));

        await app.init();

        // Login to get auth token
        const loginResponse = await request(app.getHttpServer())
            .post('/auth/login')
            .send({
                email: 'admin@test.com',
                password: 'admin123',
            });

        authToken = loginResponse.body.data.token;
    });

    afterAll(async () => {
        await app.close();
    });

    describe('/products (GET)', () => {
        it('should return array of products', () => {
            return request(app.getHttpServer())
                .get('/products')
                .expect(200)
                .expect((res) => {
                    expect(res.body.data).toHaveProperty('items');
                    expect(res.body.data).toHaveProperty('meta');
                    expect(Array.isArray(res.body.data.items)).toBe(true);
                });
        });

        it('should filter products by search term', () => {
            return request(app.getHttpServer())
                .get('/products?search=test')
                .expect(200)
                .expect((res) => {
                    const products = res.body.data.items;
                    products.forEach(product => {
                        expect(
                            product.name.toLowerCase().includes('test') ||
                            product.description.toLowerCase().includes('test')
                        ).toBe(true);
                    });
                });
        });
    });

    describe('/products (POST)', () => {
        it('should create a new product', () => {
            const newProduct = {
                name: 'Test Product',
                description: 'Test Description',
                price: 100,
                quantity: 10,
                inStock: true,
                categoryId: 1,
            };

            return request(app.getHttpServer())
                .post('/products')
                .set('Authorization', `Bearer ${authToken}`)
                .send(newProduct)
                .expect(201)
                .expect((res) => {
                    expect(res.body.data).toHaveProperty('id');
                    expect(res.body.data.name).toBe(newProduct.name);
                });
        });

        it('should validate input data', () => {
            const invalidProduct = {
                name: '',  // Invalid: empty name
                price: -100,  // Invalid: negative price
            };

            return request(app.getHttpServer())
                .post('/products')
                .set('Authorization', `Bearer ${authToken}`)
                .send(invalidProduct)
                .expect(400)
                .expect((res) => {
                    expect(res.body).toHaveProperty('errors');
                });
        });
    });

    describe('/products/:id (PUT)', () => {
        it('should update a product', async () => {
            // First create a product
            const createResponse = await request(app.getHttpServer())
                .post('/products')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    name: 'Product to Update',
                    description: 'Original Description',
                    price: 100,
                    quantity: 10,
                    inStock: true,
                    categoryId: 1,
                });

            const productId = createResponse.body.data.id;

            // Then update it
            return request(app.getHttpServer())
                .put(`/products/${productId}`)
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    name: 'Updated Product Name',
                    price: 150,
                })
                .expect(200)
                .expect((res) => {
                    expect(res.body.data.name).toBe('Updated Product Name');
                    expect(res.body.data.price).toBe(150);
                });
        });
    });
});