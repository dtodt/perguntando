import { ApiProperty } from '@nestjs/swagger';
import { Talk } from 'prisma/.prisma/client';

export class TalkEntity implements Talk {
  @ApiProperty()
  id!: number;
  @ApiProperty()
  title!: string;
  @ApiProperty()
  conferenceId!: number;
}
