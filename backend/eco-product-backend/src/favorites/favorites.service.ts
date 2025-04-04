// src/favorites/favorites.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Favorite } from '../entities/favorite.entity';
import { User } from '../entities/user.entity';
import { Product } from '../entities/product.entity';

@Injectable()
export class FavoritesService {
    constructor(
        @InjectRepository(Favorite)
        private readonly favoriteRepository: Repository<Favorite>,
        @InjectRepository(Product)
        private readonly productRepository: Repository<Product>,
    ) { }

    async addToFavorites(userId: number, productId: number): Promise<void> {
        // Kiểm tra sản phẩm có tồn tại không
        const product = await this.productRepository.findOne({
            where: { id: productId }
        });

        if (!product) {
            throw new NotFoundException(`Product with ID ${productId} not found`);
        }

        // Kiểm tra xem đã favorite chưa
        const existing = await this.favoriteRepository.findOne({
            where: {
                user: { id: userId },
                product: { id: productId }
            }
        });

        if (!existing) {
            const favorite = this.favoriteRepository.create({
                user: { id: userId },
                product: { id: productId }
            });
            await this.favoriteRepository.save(favorite);
        }
    }

    async removeFromFavorites(userId: number, productId: number): Promise<void> {
        await this.favoriteRepository.delete({
            user: { id: userId },
            product: { id: productId }
        });
    }

    async getUserFavorites(userId: number): Promise<Product[]> {
        const favorites = await this.favoriteRepository.find({
            where: { user: { id: userId } },
            relations: ['product', 'product.category']
        });

        return favorites.map(fav => fav.product);
    }

    async isProductFavorited(userId: number, productId: number): Promise<boolean> {
        const favorite = await this.favoriteRepository.findOne({
            where: {
                user: { id: userId },
                product: { id: productId }
            }
        });
        return !!favorite;
    }
}