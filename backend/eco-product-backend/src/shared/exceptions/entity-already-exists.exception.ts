import { ConflictException } from '@nestjs/common';

export class EntityAlreadyExistsException extends ConflictException {
    constructor(entity: string) {
        super(`${entity} already exists`);
    }
}