// src/sliders/sliders.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Slider } from '../entities/slider.entity';
import { CreateSliderDto } from './dto/create-slider.dto';
import { UpdateSliderDto } from './dto/update-slider.dto';

@Injectable()
export class SlidersService {
  constructor(
    @InjectRepository(Slider)
    private readonly sliderRepository: Repository<Slider>,
  ) {}

  async create(createSliderDto: CreateSliderDto): Promise<Slider> {
    const slider = this.sliderRepository.create(createSliderDto);
    return this.sliderRepository.save(slider);
  }

  async findAll(): Promise<Slider[]> {
    return this.sliderRepository.find();
  }

  async findOne(id: number): Promise<Slider> {
    const slider = await this.sliderRepository.findOne({ 
      where: { id } 
    });
    
    if (!slider) {
      throw new NotFoundException(`Slider with ID ${id} not found`);
    }
    
    return slider;
  }

  async update(id: number, updateSliderDto: UpdateSliderDto): Promise<Slider> {
    const slider = await this.findOne(id);
    Object.assign(slider, updateSliderDto);
    return this.sliderRepository.save(slider);
  }

  async remove(id: number): Promise<void> {
    const result = await this.sliderRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Slider with ID ${id} not found`);
    }
  }
}