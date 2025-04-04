// src/sliders/sliders.module.ts
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Slider } from '../entities/slider.entity';
import { SlidersController } from './sliders.controller';
import { SlidersService } from './sliders.service';

@Module({
  imports: [TypeOrmModule.forFeature([Slider])],
  controllers: [SlidersController],
  providers: [SlidersService],
})
export class SlidersModule {}