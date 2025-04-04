import { IsNumber, IsOptional, IsString } from "class-validator";

// checkout.dto.ts
export class CheckoutDto {
    @IsNumber()
    addressId: number;

    @IsNumber()
    paymentId: number;

    @IsOptional()
    @IsString()
    voucherCode?: string;

    @IsOptional()
    @IsString()
    note?: string;
}