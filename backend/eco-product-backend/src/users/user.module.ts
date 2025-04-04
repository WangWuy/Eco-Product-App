import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserController } from './user.controller';
import { UserService } from './user.service';
import { User } from 'src/entities/user.entity';
import { Address } from 'src/entities/address.entity';
import { Favorite } from 'src/entities/favorite.entity';

@Module({
  imports: [TypeOrmModule.forFeature([User, Address, Favorite])],
  controllers: [UserController],
  providers: [UserService],
})
export class UserModule {}