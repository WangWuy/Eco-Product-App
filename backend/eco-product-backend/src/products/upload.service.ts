import { Injectable } from '@nestjs/common';
import { existsSync, mkdirSync } from 'fs';
import { join } from 'path';
import * as fs from 'fs/promises';
import * as sharp from 'sharp';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class FileUploadService {
    private readonly uploadDir = 'uploads/products';

    constructor() {
        // Ensure upload directory exists
        if (!existsSync(this.uploadDir)) {
            mkdirSync(this.uploadDir, { recursive: true });
        }
    }

    async saveFile(file: Express.Multer.File): Promise<string> {
        const filename = `${uuidv4()}_${file.originalname}`;
        const filepath = join(this.uploadDir, filename);

        // Optimize image using sharp
        await sharp(file.buffer)
            .resize(800, 800, {
                fit: 'inside',
                withoutEnlargement: true
            })
            .jpeg({ quality: 80 })
            .toFile(filepath);

        return filename;
    }

    async saveMultipleFiles(files: Express.Multer.File[]): Promise<string[]> {
        const savedFiles: string[] = [];

        for (const file of files) {
            const filename = await this.saveFile(file);
            savedFiles.push(filename);
        }

        return savedFiles;
    }

    async deleteFile(filename: string): Promise<void> {
        const filepath = join(this.uploadDir, filename);
        if (existsSync(filepath)) {
            await fs.unlink(filepath);
        }
    }

    getFileUrl(filename: string): string {
        return `/uploads/products/${filename}`;
    }
}