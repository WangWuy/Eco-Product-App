import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { OrdersController } from './orders.controller';
import { OrdersService } from './orders.service';
import { Order } from '../entities/order.entity';
import { OrderItem } from '../entities/order-item.entity';
import { Product } from '../entities/product.entity';
import { Address } from 'src/entities/address.entity';
import { CartService } from 'src/carts/cart.service';
import { VoucherService } from 'src/voucher/voucher.service';
import { Payment } from 'src/entities/payment.entity';
import { Voucher } from 'src/entities/voucher.entity';
import { Cart } from 'src/entities/cart.entity';
import { CartItem } from 'src/entities/cart-item.entity';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            Order,
            OrderItem,
            Product,
            Address,
            Payment,
            Voucher,
            Cart,
            CartItem
        ])
    ],
    controllers: [OrdersController],
    providers: [
        OrdersService,
        CartService,
        VoucherService
    ],
    exports: [OrdersService]
})
export class OrdersModule { }