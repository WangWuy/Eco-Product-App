// src/entities/voucher.entity.ts
import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('vouchers')
export class Voucher {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  code: string;

  @Column()
  description: string;

  @Column('decimal', { precision: 5, scale: 2 })
  discount: number;

  @Column({ type: 'timestamp' })
  expiryDate: Date;

  @Column({ default: true })
  isActive: boolean;
}