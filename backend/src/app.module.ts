import { Module } from '@nestjs/common';

import { AuthModule } from '@auth/auth.module';
import { CommonModule } from '@common/common.module';
import { ConferencesModule } from '@conferences/conferences.module';
import { TalksModule } from '@talks/talks.module';
import { QuestionsModule } from '@questions/questions.module';

@Module({
  imports: [
    CommonModule,
    AuthModule,
    ConferencesModule,
    TalksModule,
    QuestionsModule,
  ],
})
export class AppModule {}
