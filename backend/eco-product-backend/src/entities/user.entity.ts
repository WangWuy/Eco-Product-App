import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, OneToMany, ManyToOne, JoinColumn } from 'typeorm';
import { Address } from './address.entity';
import { Favorite } from './favorite.entity';
import { Order } from './order.entity';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: true, default: '' })
  firstName: string;

  @Column({ nullable: true, default: '' })
  lastName: string;

  @Column({ unique: true })
  email: string;

  @Column({ default: '' })
  phone: string;

  @Column({ nullable: true, default: '' })
  @Column()
  gender: string;

  @Column()
  avatar: string;

  @Column()
  password: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @Column({ nullable: true })
  defaultAddressId: number;

  @ManyToOne(() => Address)
  @JoinColumn({ name: 'defaultAddressId' })
  defaultAddress: Address;
  
  @OneToMany(() => Address, address => address.user)
  addresses: Address[];

  @OneToMany(() => Favorite, favorite => favorite.user)
  favorites: Favorite[];

  @OneToMany(() => Order, order => order.user)
  orders: Order[];
}