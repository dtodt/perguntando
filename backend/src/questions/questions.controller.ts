import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';

import { CurrentUser } from '@auth/decorators/user.decorator';
import { UserEntity } from '@auth/entities';
import { AuthGuard } from '@auth/guards/auth.guard';

import { QuestionsService } from './questions.service';
import { CreateQuestionDto } from './dto/create-question.dto';
import { QuestionEntity } from './entities/question.entity';

@UseGuards(AuthGuard)
@ApiBearerAuth()
@ApiTags('questions')
@Controller('questions')
export class QuestionsController {
  constructor(private readonly service: QuestionsService) {}

  @Post()
  create(@Body() dto: CreateQuestionDto) {
    return this.service.create(dto);
  }

  @Get()
  findAll(): Promise<QuestionEntity[]> {
    return this.service.findAll();
  }

  @Get('like/:id')
  like(@Param('id') id: string, @CurrentUser() user: UserEntity) {
    this.service.like(+id, user.id);
  }

  @Get('unlike/:id')
  unlike(@Param('id') id: string, @CurrentUser() user: UserEntity) {
    this.service.unlike(+id, user.id);
  }

  @Delete(':id')
  remove(@Param('id') id: string): Promise<QuestionEntity> {
    return this.service.remove(+id);
  }
}
