import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Voucher } from "src/entities/voucher.entity";
import { MoreThan, Repository } from "typeorm";

// src/voucher/voucher.service.ts
@Injectable()
export class VoucherService {
    constructor(
        @InjectRepository(Voucher)
        private voucherRepository: Repository<Voucher>,
    ) { }

    async validateVoucher(code: string): Promise<Voucher> {
        const voucher = await this.voucherRepository.findOne({
            where: {
                code,
                isActive: true,
                expiryDate: MoreThan(new Date())
            }
        });

        if (!voucher) {
            throw new NotFoundException('Invalid or expired voucher');
        }

        return voucher;
    }
}