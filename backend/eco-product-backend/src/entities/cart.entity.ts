import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany } from 'typeorm';
import { User } from './user.entity';
import { CartItem } from './cart-item.entity';

@Entity('carts')
export class Cart {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User)
  user: User;

  @Column()
  userId: number;

  @OneToMany(() => CartItem, item => item.cart, { cascade: true })
  items: CartItem[];

  @Column('decimal', { precision: 20, scale: 2, default: 0 })
  subtotal: number;

  @Column('decimal', { precision: 20, scale: 2, default: 30000 })
  shippingFee: number;

  @Column('decimal', { precision: 20, scale: 2, default: 0 })
  tax: number;

  @Column('decimal', { precision: 20, scale: 2, default: 0 })
  total: number;
}
