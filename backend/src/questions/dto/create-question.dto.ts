import { ApiProperty } from '@nestjs/swagger';
import { Prisma } from '@prisma/client';

export class CreateQuestionDto implements Prisma.QuestionUncheckedCreateInput {
  @ApiProperty()
  id?: number | undefined;
  @ApiProperty()
  userId!: string;
  @ApiProperty()
  name!: string;
  @ApiProperty()
  imageUrl!: string;
  @ApiProperty()
  text!: string;
  @ApiProperty()
  talkId!: number;
}
