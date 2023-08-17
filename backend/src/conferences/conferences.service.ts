import { PrismaService } from '@common/prisma/prisma.service';
import { Injectable } from '@nestjs/common';
import { ConferenceEntity } from './entities/conference.entity';

@Injectable()
export class ConferencesService {
  constructor(private readonly prisma: PrismaService) {}

  findAll(): Promise<ConferenceEntity[]> {
    return this.prisma.conference.findMany();
  }
}
