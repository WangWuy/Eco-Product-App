import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { IsString, IsPhoneNumber, IsNotEmpty } from 'class-validator';
import { User } from './user.entity';

@Entity('addresses')
export class Address {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    @IsString()
    fullName: string;

    @Column()
    @IsString()
    phoneNumber: string;

    @Column()
    @IsNotEmpty()
    @IsString()
    city: string;

    @Column()
    @IsNotEmpty()
    @IsString()
    zipCode: string;

    @Column()
    @IsNotEmpty()
    @IsString()
    address: string;

    @Column()
    @IsNotEmpty()
    @IsString()
    type: string;

    @Column()
    userId: number;

    @ManyToOne(() => User, user => user.addresses)
    @JoinColumn()
    user: User;
}