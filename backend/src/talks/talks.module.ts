import { Module } from '@nestjs/common';
import { AuthModule } from '@auth/auth.module';
import { CommonModule } from '@common/common.module';

import { TalksService } from './talks.service';
import { TalksController } from './talks.controller';

@Module({
  imports: [CommonModule, AuthModule],
  controllers: [TalksController],
  providers: [TalksService],
})
export class TalksModule {}
