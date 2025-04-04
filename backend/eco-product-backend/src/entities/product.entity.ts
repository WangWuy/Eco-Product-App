import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, CreateDateColumn, UpdateDateColumn, JoinColumn, OneToMany } from 'typeorm';
import { Category } from './category.entity';
import { Favorite } from './favorite.entity';
import { ProductImage } from './product-images';

// First, define the enum
export enum ProductType {
  POPULAR = 'Popular',
  RECOMMENDED = 'Recommended',
  TRENDING = 'Trending'
}

@Entity('products')
export class Product {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ default: true })
  image: string;

  @Column('text')
  description: string;

  @Column('decimal', { precision: 10, scale: 2 })
  price: number;

  @Column()
  quantity: number;

  @Column({ default: true })
  inStock: boolean;

  // Add the new type column using the enum
  @Column({
    type: 'enum',
    enum: ProductType,
    nullable: true // Making it optional
  })
  type: ProductType;

  @Column({ name: 'categoryId', nullable: true })
  categoryId: number;

  @ManyToOne(() => Category, category => category.products, {
    nullable: true
  })
  @JoinColumn({ name: 'categoryId' })
  category: Category;

  @Column('decimal', { precision: 5, scale: 2, default: 0 })
  discount: number;  // Lưu dưới dạng phần trăm (ví dụ: 10.5 = 10.5%)

  @Column('decimal', { precision: 3, scale: 2, default: 0 })
  rating: number;  // Đánh giá từ 0-5 sao

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  get discountedPrice(): number {
    return this.price - (this.price * this.discount / 100);
  }

  @OneToMany(() => Favorite, favorite => favorite.product)
  favorites: Favorite[];

  get favoriteCount(): number {
    return this.favorites?.length || 0;
  }

  @Column({ nullable: true })
  thumbnailImage: string; // Main product image

  @OneToMany(() => ProductImage, image => image.product, {
    cascade: true
  })
  images: ProductImage[];
}