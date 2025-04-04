import { Controller, Get, Post, Delete, Body, Param, UseGuards, ParseIntPipe } from '@nestjs/common';
import { CartService } from './cart.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { GetUser } from '../auth/decorators/get-user.decorator';
import { User } from '../entities/user.entity';
import { UpdateQuantityDto } from './dto/update-cart.dto';

@Controller('cart')
@UseGuards(JwtAuthGuard)
export class CartController {
    constructor(private readonly cartService: CartService) { }

    @Get()
    getCart(@GetUser() user: User) {
        return this.cartService.getCart(user.id);
    }

    @Post('items')
    async addToCart(
        @GetUser() user: User,
        @Body() data: { productId: number; quantity: number }
    ) {
        try {
            return await this.cartService.addToCart(
                user.id,
                data.productId,
                data.quantity
            );
        } catch (error) {
            console.log('Error adding to cart:', error);
            throw error;
        }
    }

    @Delete('items/:productId')
    removeFromCart(
        @GetUser() user: User,
        @Param('productId', ParseIntPipe) productId: number
    ) {
        return this.cartService.removeFromCart(user.id, productId);
    }

    @Post('items/:productId/quantity')
    updateQuantity(
        @GetUser() user: User,
        @Param('productId', ParseIntPipe) productId: number,
        @Body() updateQuantityDto: UpdateQuantityDto
    ) {
        return this.cartService.updateQuantity(
            user.id,
            productId,
            updateQuantityDto.quantity,
            updateQuantityDto.operation
        );
    }

    @Delete('clear')
    clearCart(@GetUser() user: User) {
        return this.cartService.clearCart(user.id);
    }
}