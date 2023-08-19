import { ApiProperty } from '@nestjs/swagger';
import { Talk } from 'prisma/.prisma/client';

export class TalkEntity implements Talk {
  @ApiProperty()
  id!: number;
  @ApiProperty()
  speaker!: string;
  @ApiProperty()
  speakerImage!: string;
  @ApiProperty()
  description!: string;
  @ApiProperty()
  conferenceId!: number;
}
