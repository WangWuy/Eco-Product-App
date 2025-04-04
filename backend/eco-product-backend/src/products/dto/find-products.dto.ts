import { IsOptional, IsString, IsNumber, Min, IsIn, IsBoolean } from 'class-validator';
import { Type } from 'class-transformer';
import { ProductType } from 'src/entities/product.entity';

export class FindProductsDto {
    @IsOptional()
    @IsString()
    search?: string;

    @IsOptional()
    @Type(() => Number)
    @IsNumber()
    categoryId?: number;

    @IsOptional()
    @Type(() => Number)
    @IsNumber()
    @Min(0)
    minPrice?: number;

    @IsOptional()
    @Type(() => Number)
    @IsNumber()
    @Min(0)
    maxPrice?: number;

    @IsOptional()
    @IsBoolean()
    @Type(() => Boolean)
    inStock?: boolean;

    @IsOptional()
    @IsString()
    @IsIn(['name', 'price', 'createdAt'])
    sortBy?: string = 'createdAt';

    @IsOptional()
    @IsString()
    @IsIn(['ASC', 'DESC'])
    sortOrder?: 'ASC' | 'DESC' = 'DESC';
    
    @IsOptional()
    @IsString()
    type?: ProductType;
}