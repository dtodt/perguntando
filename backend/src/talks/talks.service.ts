import { PrismaService } from '@common/prisma/prisma.service';
import { Injectable } from '@nestjs/common';

import { TalkEntity } from './entities/talk.entity';

@Injectable()
export class TalksService {
  constructor(private readonly prisma: PrismaService) {}

  findAll(conferenceId: number): Promise<TalkEntity[]> {
    return this.prisma.talk.findMany({
      where: {
        conferenceId,
      },
    });
  }
}
