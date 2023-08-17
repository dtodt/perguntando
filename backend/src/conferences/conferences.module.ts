import { Module } from '@nestjs/common';
import { AuthModule } from '@auth/auth.module';
import { CommonModule } from '@common/common.module';

import { ConferencesService } from './conferences.service';
import { ConferencesController } from './conferences.controller';

@Module({
  imports: [CommonModule, AuthModule],
  controllers: [ConferencesController],
  providers: [ConferencesService],
})
export class ConferencesModule {}
