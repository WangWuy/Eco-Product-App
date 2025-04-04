import { Controller, Get, Post, Put, Delete, Body, Param, ParseIntPipe, UseGuards, Query, UseInterceptors, UploadedFile, UploadedFiles } from '@nestjs/common';
import { ProductsService } from './products.service';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
import { Product } from '../entities/product.entity';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { FindProductsDto } from './dto/find-products.dto';
import { GetUser } from 'src/auth/decorators/get-user.decorator';
import { User } from 'src/entities/user.entity';
import { FileInterceptor, FilesInterceptor } from '@nestjs/platform-express';
import { FileUploadService } from './upload.service';

@Controller('products')
@UseGuards(JwtAuthGuard)
export class ProductsController {
  constructor(
    private readonly productsService: ProductsService,
    private readonly fileUploadService: FileUploadService
  ) { }

  // Endpoint chính với đầy đủ các tính năng tìm kiếm và lọc
  @Get()
  findAll(
    @Query() params: FindProductsDto,
    @GetUser() user?: User
  ): Promise<Product[]> {
    return this.productsService.findAll(params, user?.id);
  }

  // Các endpoint chuyên biệt
  @Get('category/:categoryId')
  findByCategory(
    @Param('categoryId', ParseIntPipe) categoryId: number,
  ): Promise<Product[]> {
    return this.productsService.findByCategory(categoryId);
  }

  @Get('price-range')
  findByPriceRange(
    @Query('min', ParseIntPipe) minPrice: number,
    @Query('max', ParseIntPipe) maxPrice: number,
  ): Promise<Product[]> {
    return this.productsService.findByPriceRange(minPrice, maxPrice);
  }

  @Get('in-stock')
  findInStock(): Promise<Product[]> {
    return this.productsService.findInStock();
  }

  @Get('top-selling')
  findTopSelling(
    @Query('limit', ParseIntPipe) limit: number = 5,
  ): Promise<Product[]> {
    return this.productsService.findTopSelling(limit);
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number): Promise<Product> {
    return this.productsService.findOne(id);
  }

  @Put(':id')
  @UseInterceptors(FileInterceptor('thumbnail'))
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateProductDto: UpdateProductDto,
    @UploadedFile() thumbnail?: Express.Multer.File,
  ): Promise<Product> {
    return this.productsService.update(id, updateProductDto, thumbnail);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.productsService.remove(id);
  }

  @Post()
  @UseInterceptors(FileInterceptor('thumbnail'))
  async create(
    @Body() createProductDto: CreateProductDto,
    @UploadedFile() thumbnail: Express.Multer.File,
  ): Promise<Product> {
    console.log('Controller - Received request with:', {
      dto: createProductDto,
      thumbnail: thumbnail ? {
        originalname: thumbnail.originalname,
        size: thumbnail.size,
        mimetype: thumbnail.mimetype
      } : 'No thumbnail'
    });

    return this.productsService.create(createProductDto, thumbnail);
  }

  @Post(':id/images')
  @UseInterceptors(FilesInterceptor('images', 10)) // Max 10 images
  async uploadImages(
    @Param('id', ParseIntPipe) id: number,
    @UploadedFiles() images: Express.Multer.File[]
  ) {
    return this.productsService.addProductImages(id, images);
  }

  @Delete(':id/images/:imageId')
  async removeImage(
    @Param('id', ParseIntPipe) productId: number,
    @Param('imageId', ParseIntPipe) imageId: number
  ) {
    return this.productsService.removeProductImage(productId, imageId);
  }
}