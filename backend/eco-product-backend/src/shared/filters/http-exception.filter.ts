import {
    ExceptionFilter,
    Catch,
    ArgumentsHost,
    HttpException,
    HttpStatus,
} from '@nestjs/common';
import { Request, Response } from 'express';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
    catch(exception: HttpException, host: ArgumentsHost) {
        const ctx = host.switchToHttp();
        const response = ctx.getResponse<Response>();
        const request = ctx.getRequest<Request>();
        const status = exception.getStatus();

        const errorResponse = {
            statusCode: status,
            timestamp: new Date().toISOString(),
            path: request.url,
            method: request.method,
            message: exception.message || null,
            error: exception.name,
        };

        // Nếu là lỗi validation, thêm chi tiết lỗi
        if (status === HttpStatus.BAD_REQUEST) {
            const exceptionResponse = exception.getResponse() as any;
            errorResponse['errors'] = exceptionResponse.message;
        }

        response.status(status).json(errorResponse);
    }
}