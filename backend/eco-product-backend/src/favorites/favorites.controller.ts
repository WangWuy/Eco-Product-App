// src/favorites/favorites.controller.ts
import { Controller, Post, Delete, Get, Param, UseGuards } from '@nestjs/common';
import { FavoritesService } from './favorites.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { GetUser } from '../auth/decorators/get-user.decorator';
import { User } from '../entities/user.entity';
import { Product } from 'src/entities/product.entity';

@Controller('favorites')
@UseGuards(JwtAuthGuard)
export class FavoritesController {
    constructor(private readonly favoritesService: FavoritesService) { }

    @Post(':productId')
    addToFavorites(
        @GetUser() user: User,
        @Param('productId') productId: number,
    ): Promise<void> {
        return this.favoritesService.addToFavorites(user.id, productId);
    }

    @Delete(':productId')
    removeFromFavorites(
        @GetUser() user: User,
        @Param('productId') productId: number,
    ): Promise<void> {
        return this.favoritesService.removeFromFavorites(user.id, productId);
    }

    @Get()
    getUserFavorites(@GetUser() user: User): Promise<Product[]> {
        return this.favoritesService.getUserFavorites(user.id);
    }

    @Get(':productId/check')
    isProductFavorited(
        @GetUser() user: User,
        @Param('productId') productId: number,
    ): Promise<boolean> {
        return this.favoritesService.isProductFavorited(user.id, productId);
    }
}