import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Cart } from '../entities/cart.entity';
import { CartItem } from '../entities/cart-item.entity';
import { Product } from '../entities/product.entity';
import { QuantityOperation } from './dto/update-cart.dto';

@Injectable()
export class CartService {
    constructor(
        @InjectRepository(Cart)
        private cartRepository: Repository<Cart>,
        @InjectRepository(CartItem)
        private cartItemRepository: Repository<CartItem>,
        @InjectRepository(Product)
        private productRepository: Repository<Product>,
    ) { }

    async getCart(userId: number): Promise<Cart> {
        let cart = await this.cartRepository.findOne({
            where: { userId },
            relations: {
                items: {
                    product: true
                }
            }
        });

        if (!cart) {
            cart = this.cartRepository.create({ userId });
            await this.cartRepository.save(cart);
        }

        return cart;
    }

    async addToCart(userId: number, productId: number, quantity: number): Promise<Cart> {
        try {
            const product = await this.productRepository.findOneBy({ id: productId });
            if (!product) {
                throw new NotFoundException('Product not found');
            }

            let cart = await this.getCart(userId);

            console.log('Cart:', cart); // Debug log

            let cartItem = await this.cartItemRepository.findOne({
                where: {
                    cartId: cart.id,
                    productId
                }
            });

            if (cartItem) {
                cartItem.quantity += quantity;
            } else {
                cartItem = this.cartItemRepository.create({
                    cart,
                    cartId: cart.id,
                    product,
                    productId,
                    quantity
                });
            }

            await this.cartItemRepository.save(cartItem);
            return this.recalculateCart(cart.id);
        } catch (error) {
            console.log('Error in addToCart:', error);
            throw error;
        }
    }

    async removeFromCart(userId: number, productId: number): Promise<Cart> {
        const cart = await this.getCart(userId);
        await this.cartItemRepository.delete({
            cartId: cart.id,
            productId
        });
        return this.recalculateCart(cart.id);
    }

    async updateQuantity(
        userId: number,
        productId: number,
        quantity: number,
        operation: QuantityOperation
    ): Promise<Cart> {
        const cart = await this.getCart(userId);
        const cartItem = await this.cartItemRepository.findOne({
            where: {
                cartId: cart.id,
                productId
            },
            relations: ['product']
        });

        if (!cartItem) {
            throw new NotFoundException('Product not found in cart');
        }

        let newQuantity: number;

        switch (operation) {
            case QuantityOperation.ADD:
                newQuantity = cartItem.quantity + quantity;
                break;
            case QuantityOperation.SUBTRACT:
                newQuantity = cartItem.quantity - quantity;
                // Kiểm tra số lượng không âm
                if (newQuantity < 0) {
                    throw new BadRequestException('Quantity cannot be negative');
                }
                break;
            case QuantityOperation.SET:
                newQuantity = quantity;
                break;
            default:
                throw new BadRequestException('Invalid operation');
        }

        // Kiểm tra tồn kho
        if (cartItem.product.quantity < newQuantity) {
            throw new BadRequestException(
                `Cannot update quantity. Only ${cartItem.product.quantity} items available in stock`
            );
        }

        // Nếu số lượng = 0, xóa item khỏi cart
        if (newQuantity === 0) {
            await this.cartItemRepository.remove(cartItem);
        } else {
            cartItem.quantity = newQuantity;
            await this.cartItemRepository.save(cartItem);
        }

        return this.recalculateCart(cart.id);
    }

    async clearCart(userId: number): Promise<void> {
        const cart = await this.getCart(userId);
        await this.cartItemRepository.delete({ cartId: cart.id });
        await this.recalculateCart(cart.id);
    }

    private async recalculateCart(cartId: number): Promise<Cart> {
        const cart = await this.cartRepository.findOne({
            where: { id: cartId },
            relations: {
                items: {
                    product: true
                }
            }
        });

        // Chuyển price từ string sang number
        cart.subtotal = cart.items.reduce((sum, item) => {
            const price = Number(item.product.price);
            const itemTotal = price * item.quantity;
            console.log(`Item ${item.productId}:`, {
                price,
                quantity: item.quantity,
                itemTotal
            });
            return sum + itemTotal;
        }, 0);

        console.log('Subtotal:', cart.subtotal);

        // Chuyển shippingFee từ string sang number
        cart.shippingFee = Number(cart.shippingFee);

        cart.tax = Number((cart.subtotal * 0.1).toFixed(2));
        console.log('Tax:', cart.tax);

        cart.total = cart.subtotal + cart.shippingFee + cart.tax;

        console.log('Final cart values:', {
            subtotal: cart.subtotal,
            shippingFee: cart.shippingFee,
            tax: cart.tax,
            total: cart.total
        });

        return this.cartRepository.save(cart);
    }
}