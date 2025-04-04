import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ProductsController } from './products.controller';
import { ProductsService } from './products.service';
import { Product } from '../entities/product.entity';
import { Category } from '../entities/category.entity';
import { Favorite } from 'src/entities/favorite.entity';
import { ProductImage } from 'src/entities/product-images';
import { FileUploadService } from './upload.service';
import { MulterModule } from '@nestjs/platform-express';
import { memoryStorage } from 'multer';

@Module({
  imports: [TypeOrmModule.forFeature([Product, Category, Favorite, ProductImage]),
  MulterModule.register({
    storage: memoryStorage()
  })
  ],
  controllers: [ProductsController],
  providers: [ProductsService, FileUploadService],
  exports: [ProductsService],
})
export class ProductsModule { }