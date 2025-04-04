// src/sliders/dto/create-slider.dto.ts
import { IsNotEmpty, IsString } from 'class-validator';

export class CreateSliderDto {
  @IsNotEmpty()
  @IsString()
  name: string;

  @IsNotEmpty()
  @IsString()
  image: string;

  @IsNotEmpty()
  @IsString()
  offText: string;

  @IsNotEmpty()
  @IsString()
  desc: string;
}