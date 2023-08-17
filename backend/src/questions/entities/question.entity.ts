import { ApiProperty } from '@nestjs/swagger';
import { Like, Question } from 'prisma/.prisma/client';

export class QuestionEntity implements Question {
  @ApiProperty()
  id!: number;
  @ApiProperty()
  userId!: string;
  @ApiProperty()
  name!: string;
  @ApiProperty()
  imageUrl!: string;
  @ApiProperty()
  message!: string;
  @ApiProperty()
  talkId!: number;
  @ApiProperty()
  likes!: Like[];
}
