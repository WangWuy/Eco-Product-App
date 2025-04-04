import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { HttpExceptionFilter } from './shared/filters/http-exception.filter';
import { AllExceptionsFilter } from './shared/filters/all-exceptions.filter';
import { TransformInterceptor } from './shared/interceptors/transform.interceptor';
import { join } from 'path';
import { NestExpressApplication } from '@nestjs/platform-express';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  app.useStaticAssets(join(__dirname, '..', 'uploads'), {
    prefix: '/uploads/',
  });
  
  // Global Pipes
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true, // Loại bỏ các thuộc tính không được định nghĩa trong DTO
      forbidNonWhitelisted: true, // Throw error nếu có thuộc tính không được định nghĩa
      transform: true, // Tự động transform các types
    }),
  );

  // Global Filters
  app.useGlobalFilters(
    new AllExceptionsFilter(),
    new HttpExceptionFilter(),
  );

  // Global Interceptors
  app.useGlobalInterceptors(new TransformInterceptor());

  // Enable CORS
  app.enableCors({
    origin: ['http://localhost:3000', 'http://localhost:60703'
      , 'http://localhost', 'https://6386-2405-4800-5714-21a0-3c70-1832-a982-afa2.ngrok-free.app'],
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true,
  });

  await app.listen(3000);
}
bootstrap();