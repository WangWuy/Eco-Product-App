import { IsEnum, IsNumber } from "class-validator";

export enum QuantityOperation {
    ADD = 'add',
    SUBTRACT = 'subtract',
    SET = 'set'  // giữ lại operation set số lượng cụ thể
}

export class UpdateQuantityDto {
    @IsNumber()
    quantity: number;

    @IsEnum(QuantityOperation)
    operation: QuantityOperation;
}