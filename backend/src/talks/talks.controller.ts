import { Controller, Get, Param, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';

import { AuthGuard } from '@auth/guards/auth.guard';

import { TalksService } from './talks.service';
import { TalkEntity } from './entities/talk.entity';

@UseGuards(AuthGuard)
@ApiBearerAuth()
@ApiTags('talks')
@Controller('talks')
export class TalksController {
  constructor(private readonly service: TalksService) {}

  @Get(':conferenceId')
  findAll(@Param('conferenceId') conferenceId: string): Promise<TalkEntity[]> {
    return this.service.findAll(+conferenceId);
  }
}
