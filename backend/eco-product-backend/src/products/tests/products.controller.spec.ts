import { Test, TestingModule } from '@nestjs/testing';
import { ProductsController } from '../products.controller';
import { ProductsService } from '../products.service';

describe('ProductsController', () => {
    let controller: ProductsController;
    let service: ProductsService;

    const mockProductsService = {
        create: jest.fn(),
        findAll: jest.fn(),
        findOne: jest.fn(),
        update: jest.fn(),
        remove: jest.fn(),
        findByCategory: jest.fn(),
        searchProducts: jest.fn(),
        findByPriceRange: jest.fn(),
        findInStock: jest.fn(),
        findTopSelling: jest.fn(),
    };

    beforeEach(async () => {
        const module: TestingModule = await Test.createTestingModule({
            controllers: [ProductsController],
            providers: [
                {
                    provide: ProductsService,
                    useValue: mockProductsService,
                },
            ],
        }).compile();

        controller = module.get<ProductsController>(ProductsController);
        service = module.get<ProductsService>(ProductsService);
    });

    // Test cases for controller methods
    describe('findAll', () => {
        it('should return array of products', async () => {
            const result = {
                items: [
                    {
                        id: 1,
                        name: 'Test Product',
                        price: 100,
                    },
                ],
                meta: {
                    total: 1,
                    page: 1,
                    limit: 10,
                    totalPages: 1,
                    hasNextPage: false,
                    hasPreviousPage: false,
                },
            };

            mockProductsService.findAll.mockResolvedValue(result);

            expect(await controller.findAll({})).toBe(result);
        });
    });
});