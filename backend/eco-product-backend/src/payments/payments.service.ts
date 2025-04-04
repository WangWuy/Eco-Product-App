import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Payment } from '../entities/payment.entity';
import { CreatePaymentDto } from './dto/create-payment.dto';

@Injectable()
export class PaymentsService {
    constructor(
        @InjectRepository(Payment)
        private paymentRepository: Repository<Payment>,
    ) { }

    async create(userId: number, createPaymentDto: CreatePaymentDto): Promise<Payment> {
        // Mask card number for security
        if (createPaymentDto.cardNumber) {
            const maskedNumber = 'xxxx xxxx xxxx ' + createPaymentDto.cardNumber.slice(-4);
            createPaymentDto.cardNumber = maskedNumber;
        }

        const payment = this.paymentRepository.create({
            ...createPaymentDto,
            userId,
        });

        return await this.paymentRepository.save(payment);
    }

    async findByUser(userId: number): Promise<Payment[]> {
        return this.paymentRepository.find({
            where: {
                userId,
                isActive: true
            }
        });
    }

    async findOne(id: number, userId: number): Promise<Payment> {
        const payment = await this.paymentRepository.findOne({
            where: { id, userId }
        });

        if (!payment) {
            throw new NotFoundException('Payment method not found');
        }

        return payment;
    }

    async remove(id: number, userId: number): Promise<void> {
        const payment = await this.findOne(id, userId);

        // Soft delete by setting isActive to false
        payment.isActive = false;
        await this.paymentRepository.save(payment);
    }
}