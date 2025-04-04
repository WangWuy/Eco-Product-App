import { Injectable, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from '../entities/user.entity';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';

@Injectable()
export class AuthService {
    constructor(
        @InjectRepository(User)
        private userRepository: Repository<User>,
        private jwtService: JwtService,
    ) { }

    async register(registerDto: RegisterDto) {
        // Check if user already exists
        const userExists = await this.userRepository.findOne({
            where: { email: registerDto.email }
        });

        if (userExists) {
            throw new BadRequestException('User already exists');
        }

        // Hash password
        const hashedPassword = await bcrypt.hash(registerDto.password, 10);

        // Create new user
        const user = this.userRepository.create({
            ...registerDto,
            password: hashedPassword,
        });

        await this.userRepository.save(user);

        // Generate JWT token
        const token = this.generateToken(user);

        return {
            user: {
                id: user.id,
                email: user.email,
            },
            token,
        };
    }

    async login(loginDto: LoginDto) {
        // Find user
        const user = await this.userRepository.findOne({
            where: { email: loginDto.email }
        });

        if (!user) {
            throw new UnauthorizedException('Invalid credentials');
        }

        // Verify password
        const isPasswordValid = await bcrypt.compare(loginDto.password, user.password);

        if (!isPasswordValid) {
            throw new UnauthorizedException('Invalid credentials');
        }

        // Generate JWT token
        const token = this.generateToken(user);

        return {
            user: {
                id: user.id,
                email: user.email,
            },
            token,
        };
    }

    private generateToken(user: User) {
        const payload = {
            sub: user.id,
            email: user.email,
        };

        return this.jwtService.sign(payload);
    }

    async verifyToken(token: string) {
        try {
            return this.jwtService.verify(token);
        } catch (error) {
            throw new UnauthorizedException('Invalid token');
        }
    }
}