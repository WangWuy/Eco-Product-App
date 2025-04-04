import { Controller, Get, Post, Put, Delete, Param, Body, NotFoundException, UseGuards } from '@nestjs/common';
import { AddressService } from './address.service';
import { Address } from 'src/entities/address.entity';
import { GetUser } from 'src/auth/decorators/get-user.decorator';
import { User } from 'src/entities/user.entity';
import { CreateAddressDto } from './dto/create-address.dto';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';

@Controller('addresses')
@UseGuards(JwtAuthGuard)
export class AddressController {
  constructor(private readonly addressService: AddressService) { }

  @Get('user')
  async findByUser(@GetUser() user: User,) {
    return this.addressService.findByUser(user.id);
  }

  @Get()
  findAll() {
    return this.addressService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id') id: number) {
    const address = await this.addressService.findOne(id);
    if (!address) {
      throw new NotFoundException(`Address with ID ${id} not found`);
    }
    return address;
  }

  @Post()
  async create(
    @GetUser() user: User,
    @Body() createAddressDto: CreateAddressDto
  ) {
    try {
      return await this.addressService.create(user.id, createAddressDto);
    } catch (error) {
      throw error;
    }
  }

  @Put(':id')
  async update(@Param('id') id: number, @Body() address: Address) {
    const updatedAddress = await this.addressService.update(id, address);
    if (!updatedAddress) {
      throw new NotFoundException(`Address with ID ${id} not found`);
    }
    return updatedAddress;
  }

  @Delete(':id')
  async remove(@Param('id') id: number) {
    const result = await this.addressService.remove(id);
    if (!result) {
      throw new NotFoundException(`Address with ID ${id} not found`);
    }
    return { message: 'Address deleted successfully' };
  }
}
