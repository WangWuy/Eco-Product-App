import {
    Controller,
    Get,
    Post,
    Put,
    Delete,
    Body,
    Param,
    ParseIntPipe,
    HttpCode,
    HttpStatus,
    UseGuards
} from '@nestjs/common';
import { CategoriesService } from './categories.service';
import { CreateCategoryDto } from './dto/create-category.dto';
import { UpdateCategoryDto } from './dto/update-category.dto';
import { Category } from '../entities/category.entity';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('categories')
@UseGuards(JwtAuthGuard)
export class CategoriesController {
    constructor(private readonly categoriesService: CategoriesService) { }

    @Post()
    @HttpCode(HttpStatus.CREATED)
    create(@Body() createCategoryDto: CreateCategoryDto): Promise<Category> {
        return this.categoriesService.create(createCategoryDto);
    }

    @Get()
    @HttpCode(HttpStatus.OK)
    findAll(): Promise<Category[]> {
        return this.categoriesService.findAll();
    }

    @Get(':id')
    @HttpCode(HttpStatus.OK)
    findOne(@Param('id', ParseIntPipe) id: number): Promise<Category> {
        return this.categoriesService.findOne(id);
    }

    @Put(':id')
    @HttpCode(HttpStatus.OK)
    update(
        @Param('id', ParseIntPipe) id: number,
        @Body() updateCategoryDto: UpdateCategoryDto,
    ): Promise<Category> {
        return this.categoriesService.update(id, updateCategoryDto);
    }

    @Delete(':id')
    @HttpCode(HttpStatus.NO_CONTENT)
    remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
        return this.categoriesService.remove(id);
    }

    @Get(':id/product-count')
    @HttpCode(HttpStatus.OK)
    getProductCount(@Param('id', ParseIntPipe) id: number): Promise<number> {
        return this.categoriesService.getProductCount(id);
    }
}