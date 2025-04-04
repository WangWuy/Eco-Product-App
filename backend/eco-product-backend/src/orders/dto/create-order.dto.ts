export class CreateOrderDto {
    items: {
        productId: number;
        quantity: number;
    }[];
    addressId: number;
    paymentId: number;
    voucherCode?: string;
}