import { IsEnum, IsOptional, IsString, IsCreditCard, Length } from 'class-validator';
import { PaymentMethod } from '../../entities/payment.entity';

export class CreatePaymentDto {
    @IsEnum(PaymentMethod)
    method: PaymentMethod;

    @IsOptional()
    @IsCreditCard()
    cardNumber?: string;

    @IsOptional()
    @IsString()
    cardHolderName?: string;

    @IsOptional()
    @IsString()
    @Length(5, 5) 
    expiryDate?: string;

    @IsOptional()
    @IsString()
    @Length(3, 4)
    cvv?: string;
}