import { Controller, Get, Param, NotFoundException, Patch, Body, Put, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { UpdateUserDto } from './dto/update-user.dto';
import { GetUser } from 'src/auth/decorators/get-user.decorator';
import { User } from 'src/entities/user.entity';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('users')
@UseGuards(JwtAuthGuard)
export class UserController {
  constructor(private readonly userService: UserService) { }

  @Get()
  findAll() {
    return this.userService.findAll();
  }

  @Get('/detail')
  async findOne(@GetUser() user: User) {
    return this.userService.findOne(user.id);
  }

  @Get(':id/addresses')
  async findUserWithAddresses(@Param('id') id: number) {
    const user = await this.userService.findOneWithAddresses(id);
    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }
    return user;
  }

  @Put('/update')
  async update(@GetUser() user: User, @Body() updateUserDto: UpdateUserDto) {
    const updatedUser = await this.userService.update(user.id, updateUserDto);
    if (!updatedUser) {
      throw new NotFoundException(`User with ID ${user.id} not found`);
    }
    return updatedUser;
  }

  @Get(':id/favorites')
  async getUserFavorites(@Param('id') id: number) {
    const user = await this.userService.findOne(id);
    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }
    return this.userService.findUserFavorites(id);
  }
}