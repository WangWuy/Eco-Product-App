import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { Product } from './product.entity';

@Entity('product_images')
export class ProductImage {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    url: string;

    @Column()
    filename: string;

    @Column({ name: 'productId' })
    productId: number;

    @ManyToOne(() => Product, product => product.images, {
        onDelete: 'CASCADE'
    })
    product: Product;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;
}