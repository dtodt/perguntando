import { Controller, Get, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';

import { AuthGuard } from '@auth/guards/auth.guard';

import { ConferencesService } from './conferences.service';
import { ConferenceEntity } from './entities/conference.entity';

@UseGuards(AuthGuard)
@ApiBearerAuth()
@ApiTags('conferences')
@Controller('conferences')
export class ConferencesController {
  constructor(private readonly service: ConferencesService) {}

  @Get()
  findAll(): Promise<ConferenceEntity[]> {
    return this.service.findAll();
  }
}
