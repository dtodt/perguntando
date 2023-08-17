import { ApiProperty } from '@nestjs/swagger';
import { Conference } from 'prisma/.prisma/client';

export class ConferenceEntity implements Conference {
  @ApiProperty()
  id!: number;
  @ApiProperty()
  imageUrl!: string;
  @ApiProperty()
  title!: string;
}
