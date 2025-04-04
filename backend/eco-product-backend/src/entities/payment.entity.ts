import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
import { User } from './user.entity';

export enum PaymentMethod {
  CASH = 'cash',
  CREDIT_CARD = 'credit_card',
  NET_BANKING = 'net_banking'
}

@Entity('payments')
export class Payment {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User)
  user: User;

  @Column()
  userId: number;

  @Column({
    type: 'enum',
    enum: PaymentMethod
  })
  method: PaymentMethod;

  @Column({ nullable: true })
  cardNumber: string;

  @Column({ nullable: true })
  cardHolderName: string;

  @Column({ nullable: true })
  expiryDate: string;

  @Column({ nullable: true })
  cvv: string;

  @Column({ default: true })
  isActive: boolean;
}