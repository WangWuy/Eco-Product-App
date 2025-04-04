import { NotFoundException } from '@nestjs/common';

export class EntityNotFoundException extends NotFoundException {
    constructor(entity: string) {
        super(`${entity} not found`);
    }
}