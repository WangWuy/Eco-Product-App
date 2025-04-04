// src/entities/order.entity.ts
import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, CreateDateColumn, UpdateDateColumn, JoinColumn } from 'typeorm';
import { User } from './user.entity';
import { OrderItem } from './order-item.entity';
import { Address } from './address.entity';
import { Voucher } from './voucher.entity';
import { Payment } from './payment.entity';

export enum OrderStatus {
  PENDING = 'pending',
  PROCESSING = 'processing', 
  SHIPPING = 'shipping',
  DELIVERED = 'delivered',
  CANCELLED = 'cancelled'
}

@Entity('orders')
export class Order {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User, user => user.orders)
  user: User;

  @Column()
  userId: number;

  @OneToMany(() => OrderItem, orderItem => orderItem.order, {
    cascade: true
  })
  items: OrderItem[];

  @ManyToOne(() => Address)
  @JoinColumn({ name: 'addressId' })
  address: Address;

  @Column()
  addressId: number;

  @Column({
    type: 'enum',
    enum: OrderStatus,
    default: OrderStatus.PENDING
  })
  status: OrderStatus;

  @Column('decimal', { precision: 10, scale: 2 })
  subtotal: number;

  @Column('decimal', { precision: 10, scale: 2 })
  shippingFee: number;

  @Column('decimal', { precision: 10, scale: 2 })
  tax: number;

  @Column('decimal', { precision: 10, scale: 2, default: 0 })
  discount: number;

  @Column('decimal', { precision: 10, scale: 2 })
  totalAmount: number;

  @ManyToOne(() => Voucher, { nullable: true })
  voucher: Voucher;

  @Column({ nullable: true })
  voucherId: number;

  @ManyToOne(() => Payment)
  payment: Payment;

  @Column()
  paymentId: number;

  @Column({ nullable: true })
  note: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}