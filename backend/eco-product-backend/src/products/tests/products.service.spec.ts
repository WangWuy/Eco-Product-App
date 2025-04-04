import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ProductsService } from '../products.service';
import { Product } from '../../entities/product.entity';
import { EntityNotFoundException } from '../../shared/exceptions/entity-not-found.exception';

describe('ProductsService', () => {
    let service: ProductsService;
    let productRepository: Repository<Product>;

    const mockProduct = {
        id: 1,
        name: 'Test Product',
        description: 'Test Description',
        price: 100,
        quantity: 10,
        inStock: true,
        category: { id: 1, name: 'Test Category' },
    };

    const mockProductRepository = {
        create: jest.fn(),
        save: jest.fn(),
        find: jest.fn(),
        findOne: jest.fn(),
        delete: jest.fn(),
        createQueryBuilder: jest.fn(() => ({
            leftJoinAndSelect: jest.fn().mockReturnThis(),
            where: jest.fn().mockReturnThis(),
            andWhere: jest.fn().mockReturnThis(),
            orderBy: jest.fn().mockReturnThis(),
            skip: jest.fn().mockReturnThis(),
            take: jest.fn().mockReturnThis(),
            getMany: jest.fn(),
            getCount: jest.fn(),
        })),
    };

    beforeEach(async () => {
        const module: TestingModule = await Test.createTestingModule({
            providers: [
                ProductsService,
                {
                    provide: getRepositoryToken(Product),
                    useValue: mockProductRepository,
                },
            ],
        }).compile();

        service = module.get<ProductsService>(ProductsService);
        productRepository = module.get<Repository<Product>>(getRepositoryToken(Product));
    });

    describe('create', () => {
        it('should successfully create a product', async () => {
            const createProductDto = {
                name: 'New Product',
                description: 'New Description',
                price: 200,
                quantity: 5,
                inStock: true,
                categoryId: 1,
            };

            mockProductRepository.create.mockReturnValue(mockProduct);
            mockProductRepository.save.mockResolvedValue(mockProduct);

            const result = await service.create(createProductDto);

            expect(result).toEqual(mockProduct);
            expect(mockProductRepository.create).toHaveBeenCalledWith(createProductDto);
            expect(mockProductRepository.save).toHaveBeenCalled();
        });
    });

    describe('findOne', () => {
        it('should return a product if found', async () => {
            mockProductRepository.findOne.mockResolvedValue(mockProduct);

            const result = await service.findOne(1);

            expect(result).toEqual(mockProduct);
            expect(mockProductRepository.findOne).toHaveBeenCalledWith({
                where: { id: 1 },
                relations: ['category'],
            });
        });

        it('should throw EntityNotFoundException if product not found', async () => {
            mockProductRepository.findOne.mockResolvedValue(null);

            await expect(service.findOne(999)).rejects.toThrow(EntityNotFoundException);
        });
    });

    describe('findAll with filters', () => {
        it('should return filtered and paginated products', async () => {
            const findProductsDto = {
                search: 'test',
                categoryId: 1,
                minPrice: 50,
                maxPrice: 150,
                inStock: true,
                sortBy: 'price',
                sortOrder: 'DESC' as 'ASC' | 'DESC',
                page: 1,
                limit: 10,
            };

            const mockQueryBuilder = mockProductRepository.createQueryBuilder();
            mockQueryBuilder.getMany.mockResolvedValue([mockProduct]);
            mockQueryBuilder.getCount.mockResolvedValue(1);

            const result = await service.findAll(findProductsDto);

            expect(result.items).toEqual([mockProduct]);
            expect(result.meta.total).toBe(1);
            expect(mockProductRepository.createQueryBuilder).toHaveBeenCalled();
        });
    });
});