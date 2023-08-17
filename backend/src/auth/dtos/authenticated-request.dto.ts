import { UserEntity } from '@auth/entities';
import { Request } from 'express';

export interface AuthenticatedRequest extends Request {
  user: UserEntity;
}
