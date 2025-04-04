import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Address } from 'src/entities/address.entity';
import { Repository } from 'typeorm';
import { CreateAddressDto } from './dto/create-address.dto';

@Injectable()
export class AddressService {
  constructor(
    @InjectRepository(Address)
    private addressRepository: Repository<Address>,
  ) { }

  findAll(): Promise<Address[]> {
    return this.addressRepository.find({
      relations: ['user'],
    });
  }

  findOne(id: number): Promise<Address | null> {
    return this.addressRepository.findOne({
      where: { id },
      relations: ['user'],
    });
  }

  findByUser(userId: number): Promise<Address[]> {
    return this.addressRepository.find({
      where: { userId },
      relations: ['user'],
    });
  }

  async create(userId: number, createAddressDto: CreateAddressDto): Promise<Address> {
    try {
      // Format phone number nếu cần
      if (!createAddressDto.phoneNumber.startsWith('+')) {
        createAddressDto.phoneNumber = '+84' + createAddressDto.phoneNumber.replace(/^0/, '');
      }

      const address = this.addressRepository.create({
        ...createAddressDto,
        userId
      });
      const savedAddress = await this.addressRepository.save(address);

      return savedAddress;
    } catch (error) {
      console.error('Error in address service:', error);
      throw error;
    }
  }

  async update(id: number, updatedAddress: Address): Promise<Address | null> {
    await this.addressRepository.update(id, updatedAddress);
    return this.findOne(id);
  }

  async remove(id: number): Promise<boolean> {
    const result = await this.addressRepository.delete(id);
    return result.affected > 0;
  }
}