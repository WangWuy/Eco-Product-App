// src/orders/orders.service.ts
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order, OrderStatus } from '../entities/order.entity';
import { OrderItem } from '../entities/order-item.entity';
import { Product } from '../entities/product.entity';
import { CreateOrderDto } from './dto/create-order.dto';
import { Address } from 'src/entities/address.entity';
import { Payment } from 'src/entities/payment.entity';
import { CartService } from 'src/carts/cart.service';
import { VoucherService } from 'src/voucher/voucher.service';
import { CheckoutDto } from './dto/checkout.dto';

@Injectable()
export class OrdersService {
    constructor(
        @InjectRepository(Order)
        private orderRepository: Repository<Order>,
        @InjectRepository(OrderItem)
        private orderItemRepository: Repository<OrderItem>,
        @InjectRepository(Product)
        private productRepository: Repository<Product>,
        @InjectRepository(Address)
        private addressRepository: Repository<Address>,
        @InjectRepository(Payment)
        private paymentRepository: Repository<Payment>,
        private cartService: CartService,
        private voucherService: VoucherService,
    ) { }

    // Tạo đơn hàng trực tiếp
    async create(userId: number, createOrderDto: CreateOrderDto): Promise<Order> {
        // Validate address
        const address = await this.addressRepository.findOne({
            where: { id: createOrderDto.addressId, userId }
        });
        if (!address) {
            throw new NotFoundException('Address not found');
        }

        // Validate payment
        const payment = await this.paymentRepository.findOne({
            where: { id: createOrderDto.paymentId, userId }
        });
        if (!payment) {
            throw new NotFoundException('Payment method not found');
        }

        // Validate voucher if provided
        let voucher;
        if (createOrderDto.voucherCode) {
            voucher = await this.voucherService.validateVoucher(createOrderDto.voucherCode);
        }

        // Create order items and calculate total
        const items: OrderItem[] = [];
        let subtotal = 0;

        for (const item of createOrderDto.items) {
            const product = await this.productRepository.findOneBy({ id: item.productId });
            if (!product) {
                throw new NotFoundException(`Product ${item.productId} not found`);
            }

            if (product.quantity < item.quantity) {
                throw new BadRequestException(`Product ${product.name} only has ${product.quantity} items left`);
            }

            const orderItem = this.orderItemRepository.create({
                product,
                productId: product.id,
                quantity: item.quantity,
                price: product.price
            });

            subtotal += product.price * item.quantity;
            items.push(orderItem);

            // Update product quantity
            product.quantity -= item.quantity;
            await this.productRepository.save(product);
        }

        // Calculate fees and total
        const shippingFee = 30000.00;
        const tax = subtotal * 0.1;
        const discount = voucher ? (subtotal * voucher.discount / 100) : 0;
        const totalAmount = subtotal + shippingFee + tax - discount;

        // Create and save order
        const order = this.orderRepository.create({
            userId,
            items,
            addressId: address.id,
            paymentId: payment.id,
            voucherId: voucher?.id,
            status: OrderStatus.PENDING,
            subtotal,
            shippingFee,
            tax,
            discount,
            totalAmount
        });

        return this.orderRepository.save(order);
    }

    // Tạo đơn hàng từ giỏ hàng
    async createFromCart(userId: number, checkoutDto: CheckoutDto): Promise<Order> {
        const { addressId, paymentId, voucherCode, note } = checkoutDto;
        const cart = await this.cartService.getCart(userId);

        if (!cart.items.length) {
            throw new BadRequestException('Cart is empty');
        }

        // Validate address
        const address = await this.addressRepository.findOne({
            where: { id: addressId, userId }
        });
        if (!address) {
            throw new NotFoundException('Address not found');
        }

        // Validate payment
        const payment = await this.paymentRepository.findOne({
            where: { id: paymentId, userId }
        });
        if (!payment) {
            throw new NotFoundException('Payment method not found');
        }

        // Check voucher
        let voucher;
        if (voucherCode) {
            voucher = await this.voucherService.validateVoucher(voucherCode);
        }

        // Convert cart items to order items
        const orderItems = cart.items.map(item => ({
            productId: item.productId,
            quantity: item.quantity,
            price: Number(item.product.price)
        }));

        // Calculate totals
        const discount = voucher ? (Number(cart.subtotal) * voucher.discount / 100) : 0;
        const totalAmount = Number(cart.total) - discount;

        const order = this.orderRepository.create({
            userId,
            addressId,
            paymentId,
            voucherId: voucher?.id,
            items: orderItems,
            status: OrderStatus.PENDING,
            subtotal: Number(cart.subtotal),
            shippingFee: Number(cart.shippingFee),
            tax: Number(cart.tax),
            discount,
            totalAmount,
            note
        });

        await this.orderRepository.save(order);
        await this.cartService.clearCart(userId);

        return this.orderRepository.findOne({
            where: { id: order.id },
            relations: ['items', 'address', 'payment', 'voucher']
        });
    }

    async findAll(userId: number): Promise<Order[]> {
        return this.orderRepository.find({
            where: { userId },
            relations: {
                items: {
                    product: {
                        category: true
                    }
                },
                address: true,
                payment: true,
                voucher: true
            },
            order: {
                createdAt: 'DESC'
            }
        });
    }

    async findOne(id: number, userId: number): Promise<Order> {
        const order = await this.orderRepository.findOne({
            where: { id, userId },
            relations: {
                items: {
                    product: {
                        category: true
                    }
                },
                address: true,
                payment: true,
                voucher: true
            }
        });

        if (!order) {
            throw new NotFoundException(`Order ${id} not found`);
        }

        return order;
    }

    async updateStatus(id: number, status: OrderStatus): Promise<Order> {
        const order = await this.orderRepository.findOne({
            where: { id },
            relations: ['items']
        });

        if (!order) {
            throw new NotFoundException(`Order ${id} not found`);
        }

        // Nếu đơn hàng bị hủy, cập nhật lại số lượng trong kho
        if (status === OrderStatus.CANCELLED) {
            for (const item of order.items) {
                const product = await this.productRepository.findOne({
                    where: { id: item.productId }
                });
                product.quantity += item.quantity;
                await this.productRepository.save(product);
            }
        }

        order.status = status;
        return this.orderRepository.save(order);
    }
}