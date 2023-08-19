import { PrismaService } from '@common/prisma/prisma.service';
import { Injectable } from '@nestjs/common';

import { CreateQuestionDto } from './dto/create-question.dto';
import { QuestionEntity } from './entities/question.entity';

@Injectable()
export class QuestionsService {
  constructor(private readonly prisma: PrismaService) {}

  create(dto: CreateQuestionDto): Promise<QuestionEntity> {
    return this.prisma.question.create({
      data: dto,
      include: {
        likes: true,
      },
    });
  }

  findAll(talkId: number): Promise<QuestionEntity[]> {
    return this.prisma.question.findMany({
      where: {
        talkId,
      },
      include: {
        likes: true,
      },
    });
  }

  like(questionId: number, userId: string) {
    this.prisma.like.create({
      data: {
        questionId,
        userId,
      },
    });
  }

  unlike(questionId: number, userId: string) {
    this.prisma.like.deleteMany({
      where: {
        questionId,
        userId,
      },
    });
  }

  remove(id: number): Promise<QuestionEntity> {
    return this.prisma.question.delete({
      where: {
        id,
      },
      include: {
        likes: true,
      },
    });
  }
}
