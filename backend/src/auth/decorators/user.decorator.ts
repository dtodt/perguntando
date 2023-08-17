import { createParamDecorator, ExecutionContext } from '@nestjs/common';

import { kUser } from '@auth/auth.constants';
import { AuthenticatedRequest } from '@auth/dtos';

export const CurrentUser = createParamDecorator(
  (_, context: ExecutionContext) => {
    const request = context.switchToHttp().getRequest<AuthenticatedRequest>();
    return request[kUser];
  },
);
