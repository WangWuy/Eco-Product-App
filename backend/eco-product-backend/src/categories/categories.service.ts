import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Category } from '../entities/category.entity';
import { CreateCategoryDto } from './dto/create-category.dto';
import { UpdateCategoryDto } from './dto/update-category.dto';

@Injectable()
export class CategoriesService {
    constructor(
        @InjectRepository(Category)
        private readonly categoryRepository: Repository<Category>,
    ) { }

    async create(createCategoryDto: CreateCategoryDto): Promise<Category> {
        const category = this.categoryRepository.create(createCategoryDto);
        await this.categoryRepository.save(category);
        return this.findOne(category.id);
    }

    async findAll(): Promise<Category[]> {
        return await this.categoryRepository.find({
          relations: {
            products: true
          }
        });
    }

    async findOne(id: number): Promise<Category> {
        const category = await this.categoryRepository.findOne({
          where: { id },
          relations: {
            products: true
          }
        });
    
        if (!category) {
          throw new NotFoundException(`Category with ID ${id} not found`);
        }
    
        return category;
    }

    async update(id: number, updateCategoryDto: UpdateCategoryDto): Promise<Category> {
        const category = await this.findOne(id);
        Object.assign(category, updateCategoryDto);
        await this.categoryRepository.save(category);
        return this.findOne(id);
    }

    async remove(id: number): Promise<void> {
        const category = await this.findOne(id);
        
        if (category.products && category.products.length > 0) {
          throw new Error('Cannot delete category that has products');
        }
    
        const result = await this.categoryRepository.delete(id);
        if (result.affected === 0) {
          throw new NotFoundException(`Category with ID ${id} not found`);
        }
    }

    // Thêm method để đếm số sản phẩm trong category
    async getProductCount(id: number): Promise<number> {
        const category = await this.categoryRepository.findOne({
            where: { id },
            relations: ['products'],
        });

        if (!category) {
            throw new NotFoundException('Category not found');
        }

        return category.products.length;
    }
}
