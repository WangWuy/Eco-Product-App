// src/entities/favorite.entity.ts
import { Entity, PrimaryGeneratedColumn, ManyToOne, CreateDateColumn } from 'typeorm';
import { User } from './user.entity';
import { Product } from './product.entity';

@Entity('favorites')
export class Favorite {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => User, user => user.favorites)
  user: User;

  @ManyToOne(() => Product, product => product.favorites)
  product: Product;

  @CreateDateColumn()
  createdAt: Date;
}