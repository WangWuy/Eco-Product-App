import { Controller, Get, Post, Body, Param, Delete, UseGuards, BadRequestException } from '@nestjs/common';
import { PaymentsService } from './payments.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { GetUser } from '../auth/decorators/get-user.decorator';
import { User } from '../entities/user.entity';
import { CreatePaymentDto } from './dto/create-payment.dto';

@Controller('payments')
@UseGuards(JwtAuthGuard)
export class PaymentsController {
    constructor(private readonly paymentsService: PaymentsService) { }

    @Post()
    async create(
        @GetUser() user: User,
        @Body() createPaymentDto: CreatePaymentDto
    ) {
        try {
            // Validate card info if method is credit card
            if (createPaymentDto.method === 'credit_card') {
                if (!createPaymentDto.cardNumber || !createPaymentDto.cardHolderName ||
                    !createPaymentDto.expiryDate || !createPaymentDto.cvv) {
                    throw new BadRequestException('Card information is required for credit card payment');
                }
            }

            return await this.paymentsService.create(user.id, createPaymentDto);
        } catch (error) {
            throw error;
        }
    }

    @Get()
    findAll(@GetUser() user: User) {
        return this.paymentsService.findByUser(user.id);
    }

    @Get(':id')
    findOne(@GetUser() user: User, @Param('id') id: number) {
        return this.paymentsService.findOne(id, user.id);
    }

    @Delete(':id')
    remove(@GetUser() user: User, @Param('id') id: number) {
        return this.paymentsService.remove(id, user.id);
    }
}