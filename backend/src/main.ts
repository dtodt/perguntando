import { NestFactory } from '@nestjs/core';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const config = new DocumentBuilder()
    .setTitle('Perguntando')
    .setDescription('API')
    .setVersion('1.0')
    .addTag('conferences')
    .addTag('talks')
    .addTag('questions')
    .addBearerAuth()
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document, {
    customSiteTitle: 'Perguntando API',
    swaggerOptions: {
      deepLink: true,
      persistAuthorization: true,
    },
  });

  await app.listen(3000);
}
bootstrap();
