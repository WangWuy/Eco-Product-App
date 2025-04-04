// src/products/products.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Like, Between } from 'typeorm';
import { Product, ProductType } from '../entities/product.entity';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
import { FindProductsDto } from './dto/find-products.dto';
import { Category } from 'src/entities/category.entity';
import { ProductImage } from 'src/entities/product-images';
import { FileUploadService } from './upload.service';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(Product)
    private readonly productRepository: Repository<Product>,
    @InjectRepository(ProductImage)
    private readonly productImageRepository: Repository<ProductImage>,
    @InjectRepository(Category)
    private readonly categoryRepository: Repository<Category>,
    private readonly fileUploadService: FileUploadService,
  ) { }

  async create(createProductDto: CreateProductDto, thumbnail?: Express.Multer.File): Promise<Product> {
    // Kiểm tra category tồn tại (logic cũ)
    const category = await this.categoryRepository.findOne({
      where: { id: createProductDto.categoryId }
    });

    if (!category) {
      throw new NotFoundException(`Category with ID ${createProductDto.categoryId} not found`);
    }

    // Xử lý thumbnail nếu có (chức năng mới)
    let thumbnailFilename: string | null = null;
    if (thumbnail) {
      thumbnailFilename = await this.fileUploadService.saveFile(thumbnail);
    }

    // Tạo mới product với reference đến category (logic cũ)
    const product = this.productRepository.create({
      ...createProductDto,
      category: category,
      categoryId: category.id,
      image: this.fileUploadService.getFileUrl(thumbnailFilename), // Set cho trường image cũ
      thumbnailImage: thumbnailFilename ? this.fileUploadService.getFileUrl(thumbnailFilename) : null
    });

    // Lưu product (logic cũ)
    const savedProduct = await this.productRepository.save(product);

    // Query lại product với relation (logic cũ)
    return this.productRepository.findOne({
      where: { id: savedProduct.id },
      relations: {
        category: true,
        images: true // thêm relation với images
      }
    });
  }

  async findOne(id: number): Promise<Product> {
    const product = await this.productRepository.findOne({
      where: { id },
      relations: {
        category: true
      }
    });

    if (!product) {
      throw new NotFoundException(`Product with ID ${id} not found`);
    }

    return product;
  }

  async update(
    id: number,
    updateProductDto: UpdateProductDto,
    thumbnail?: Express.Multer.File
  ): Promise<Product> {
    console.log('Service - Start updating product:', { id, dto: updateProductDto });

    let product = await this.findOne(id);

    // Xử lý category nếu có thay đổi
    if (updateProductDto.categoryId) {
      console.log('Service - Updating category for product');
      const category = await this.categoryRepository.findOne({
        where: { id: updateProductDto.categoryId }
      });

      if (!category) {
        throw new NotFoundException(`Category with ID ${updateProductDto.categoryId} not found`);
      }

      product.category = category;
      product.categoryId = category.id;
    }

    // Xử lý thumbnail nếu có file mới
    if (thumbnail) {
      console.log('Service - Processing new thumbnail');
      try {
        // Xóa file thumbnail cũ nếu có
        if (product.thumbnailImage) {
          const oldFilename = product.thumbnailImage.split('/').pop(); // Lấy tên file từ URL
          await this.fileUploadService.deleteFile(oldFilename);
        }

        // Lưu file mới
        const thumbnailFilename = await this.fileUploadService.saveFile(thumbnail);
        const thumbnailUrl = this.fileUploadService.getFileUrl(thumbnailFilename);

        // Cập nhật cả image và thumbnailImage
        product.image = thumbnailUrl;
        product.thumbnailImage = thumbnailUrl;

        console.log('Service - Updated thumbnail:', thumbnailUrl);
      } catch (error) {
        console.error('Service - Error updating thumbnail:', error);
        throw error;
      }
    }

    // Update các field khác
    Object.assign(product, updateProductDto);
    console.log('Service - Product after updates:', product);

    // Lưu product
    const savedProduct = await this.productRepository.save(product);
    console.log('Service - Saved product:', savedProduct);

    // Query lại để lấy data mới nhất với relations
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    const result = await this.productRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Product with ID ${id} not found`);
    }
  }

  async findAll(params: FindProductsDto, userId?: number): Promise<Product[]> {
    const {
      search,
      categoryId,
      type,
    } = params;

    // Xây dựng query
    const query = this.productRepository.createQueryBuilder('product')
      .leftJoinAndSelect('product.category', 'category')

    // Nếu có userId thì join với favorites để check
    if (userId) {
      query.leftJoin('product.favorites', 'favorites', 'favorites.userId = :userId', { userId });
    }

    // Tìm kiếm theo tên hoặc mô tả
    if (search) {
      query.andWhere(
        '(LOWER(product.name) LIKE LOWER(:search) OR LOWER(product.description) LIKE LOWER(:search))',
        { search: `%${search}%` }
      );
    }

    // Lọc theo category
    if (categoryId) {
      query.andWhere('category.id = :categoryId', { categoryId });
    }

    // Lọc theo type
    if (type) {
      query.andWhere('product.type = :type', { type });
    }

    // Thực hiện query để lấy kết quả
    const products = await query.getMany();

    // Nếu có search term và có kết quả, update type thành Recommended
    if (search && products.length > 0) {
      const productIds = products.map(product => product.id);
      await this.productRepository
        .createQueryBuilder()
        .update(Product)
        .set({ type: ProductType.RECOMMENDED })
        .whereInIds(productIds)
        .execute();
    }

    return products;
  }

  async findByCategory(categoryId: number): Promise<Product[]> {
    return this.productRepository.find({
      where: { category: { id: categoryId } },
      relations: ['category'],
    });
  }

  async findByPriceRange(minPrice: number, maxPrice: number): Promise<Product[]> {
    return this.productRepository.find({
      where: {
        price: Between(minPrice, maxPrice),
      },
      relations: ['category'],
    });
  }

  async findInStock(): Promise<Product[]> {
    return this.productRepository.find({
      where: { inStock: true },
      relations: ['category'],
    });
  }

  async findTopSelling(limit: number = 5): Promise<Product[]> {
    return this.productRepository.find({
      order: {
        quantity: 'DESC',
      },
      take: limit,
      relations: ['category'],
    });
  }

  async addProductImages(productId: number, images: Express.Multer.File[]): Promise<Product> {
    console.log('Service - Adding images to product:', productId);

    const product = await this.findOne(productId);

    try {
      const savedFilenames = await this.fileUploadService.saveMultipleFiles(images);

      const productImages = savedFilenames.map(filename =>
        this.productImageRepository.create({
          filename,
          url: this.fileUploadService.getFileUrl(filename),
          productId: product.id
        })
      );

      await this.productImageRepository.save(productImages);
      console.log('Service - Added new images:', productImages);

      return this.findOne(productId);
    } catch (error) {
      console.error('Service - Error adding images:', error);
      throw error;
    }
  }

  // Thêm hàm xóa ảnh
  async removeProductImage(productId: number, imageId: number): Promise<void> {
    console.log('Service - Removing image:', { productId, imageId });

    const image = await this.productImageRepository.findOne({
      where: { id: imageId, productId }
    });

    if (!image) {
      throw new NotFoundException(`Image with ID ${imageId} not found for product ${productId}`);
    }

    try {
      await this.fileUploadService.deleteFile(image.filename);
      await this.productImageRepository.remove(image);
      console.log('Service - Successfully removed image');
    } catch (error) {
      console.error('Service - Error removing image:', error);
      throw error;
    }
  }
}