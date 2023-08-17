import { Module } from '@nestjs/common';
import { AuthModule } from '@auth/auth.module';
import { CommonModule } from '@common/common.module';

import { QuestionsService } from './questions.service';
import { QuestionsController } from './questions.controller';

@Module({
  imports: [CommonModule, AuthModule],
  controllers: [QuestionsController],
  providers: [QuestionsService],
})
export class QuestionsModule {}
