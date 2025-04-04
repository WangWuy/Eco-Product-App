// src/sliders/sliders.controller.ts
import { Controller, Get, Post, Put, Delete, Body, Param, ParseIntPipe, UseGuards } from '@nestjs/common';
import { SlidersService } from './sliders.service';
import { CreateSliderDto } from './dto/create-slider.dto';
import { UpdateSliderDto } from './dto/update-slider.dto';
import { Slider } from '../entities/slider.entity';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('sliders')
export class SlidersController {
  constructor(private readonly slidersService: SlidersService) {}

  @Post()
  @UseGuards(JwtAuthGuard)
  create(@Body() createSliderDto: CreateSliderDto): Promise<Slider> {
    return this.slidersService.create(createSliderDto);
  }

  @Get()
  findAll(): Promise<Slider[]> {
    return this.slidersService.findAll();
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number): Promise<Slider> {
    return this.slidersService.findOne(id);
  }

  @Put(':id')
  @UseGuards(JwtAuthGuard)
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateSliderDto: UpdateSliderDto,
  ): Promise<Slider> {
    return this.slidersService.update(id, updateSliderDto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.slidersService.remove(id);
  }
}