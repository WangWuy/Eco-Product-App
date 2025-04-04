import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../entities/user.entity';
import { UpdateUserDto } from './dto/update-user.dto';
import { Product } from '../entities/product.entity';
import { Favorite } from '../entities/favorite.entity';
import { Address } from '../entities/address.entity';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
    @InjectRepository(Favorite)
    private favoriteRepository: Repository<Favorite>,
    @InjectRepository(Address)
    private addressRepository: Repository<Address>,
  ) { }

  findAll(): Promise<User[]> {
    return this.userRepository.find();
  }

  async findOne(id: number): Promise<User> {
    return this.userRepository.findOne({
      where: { id },
      relations: ['addresses', 'defaultAddress']
    });
  }

  findOneWithAddresses(id: number): Promise<User | null> {
    return this.userRepository.findOne({
      where: { id },
      relations: ['addresses'],
    });
  }

  async update(id: number, updateUserDto: UpdateUserDto): Promise<User> {
    const { defaultAddressId, ...updateData } = updateUserDto;

    if (defaultAddressId) {
      const address = await this.addressRepository.findOne({
        where: {
          id: defaultAddressId,
          userId: id
        }
      });

      if (!address) {
        throw new NotFoundException('Address not found or not belong to user');
      }      
    }

    await this.userRepository.update(id, {
      ...updateData,
      defaultAddressId
    });

    return this.userRepository.findOne({
      where: { id },
      relations: ['addresses', 'defaultAddress']
    });
  }

  async findUserFavorites(userId: number): Promise<Product[]> {
    const favorites = await this.favoriteRepository.find({
      where: { user: { id: userId } },
      relations: {
        product: {
          category: true
        }
      }
    });

    if (!favorites.length) {
      return [];
    }

    return favorites.map(fav => fav.product);
  }
}