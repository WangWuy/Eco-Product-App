import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Product } from './entities/product.entity';
import { Category } from './entities/category.entity';
import { User } from './entities/user.entity';
import { ProductsModule } from './products/products.module';
import { CategoriesModule } from './categories/categories.module';
import { AuthModule } from './auth/auth.module';
import { CategoriesController } from './categories/categories.controller';
import { Address } from './entities/address.entity';
import { UserModule } from './users/user.module';
import { AddressModule } from './addresses/address.module';
import { Slider } from './entities/slider.entity';
import { SlidersModule } from './sliders/sliders.module';
import { Favorite } from './entities/favorite.entity';
import { FavoritesModule } from './favorites/favorites.module';
import { Order } from './entities/order.entity';
import { OrderItem } from './entities/order-item.entity';
import { OrdersModule } from './orders/orders.module';
import { Cart } from './entities/cart.entity';
import { CartItem } from './entities/cart-item.entity';
import { CartModule } from './carts/cart.module';
import { Voucher } from './entities/voucher.entity';
import { Payment } from './entities/payment.entity';
import { PaymentsModule } from './payments/payments.module';
import { ProductImage } from './entities/product-images';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.get('DB_HOST'),
        port: configService.get('DB_PORT'),
        username: configService.get('DB_USERNAME'),
        password: configService.get('DB_PASSWORD'),
        database: configService.get('DB_NAME'),
        entities: [Product, Category, User, Address, Slider, Favorite, Order, OrderItem, Cart, CartItem, Voucher, Payment, ProductImage],
        synchronize: true, 
      }),
      inject: [ConfigService],
    }),
    ProductsModule,
    CategoriesModule,
    AuthModule,
    UserModule,
    AddressModule,
    SlidersModule,
    FavoritesModule,
    OrdersModule,
    CartModule,
    PaymentsModule,
  ],
  controllers: [CategoriesController],
})
export class AppModule {}
