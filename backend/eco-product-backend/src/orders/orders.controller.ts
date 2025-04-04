import { Controller, Get, Post, Body, Param, Put, UseGuards } from '@nestjs/common';
import { OrdersService } from './orders.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { GetUser } from '../auth/decorators/get-user.decorator';
import { User } from '../entities/user.entity';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderStatusDto } from './dto/update-order-status.dto';
import { CheckoutDto } from './dto/checkout.dto';

@Controller('orders')
@UseGuards(JwtAuthGuard)
export class OrdersController {
    constructor(
        private readonly ordersService: OrdersService,
    ) { }

    // Tạo đơn hàng trực tiếp từ danh sách sản phẩm
    @Post()
    create(
        @GetUser() user: User,
        @Body() createOrderDto: CreateOrderDto
    ) {
        return this.ordersService.create(user.id, createOrderDto);
    }

    // Tạo đơn hàng từ giỏ hàng (checkout)
    @Post('checkout')
    async checkout(
        @GetUser() user: User,
        @Body() checkoutDto: CheckoutDto
    ) {
        return this.ordersService.createFromCart(user.id, checkoutDto);
    }

    @Get()
    findAll(@GetUser() user: User) {
        return this.ordersService.findAll(user.id);
    }

    @Get(':id')
    findOne(
        @GetUser() user: User,
        @Param('id') id: number
    ) {
        return this.ordersService.findOne(id, user.id);
    }

    @Put(':id/status')
    updateStatus(
        @Param('id') id: number,
        @Body() updateOrderStatusDto: UpdateOrderStatusDto
    ) {
        return this.ordersService.updateStatus(id, updateOrderStatusDto.status);
    }
}