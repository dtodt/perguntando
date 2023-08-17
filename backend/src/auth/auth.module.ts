import { Module } from '@nestjs/common';
import { FirebaseService } from './firebase/firebase.service';

@Module({
  exports: [FirebaseService],
  providers: [FirebaseService],
})
export class AuthModule {}
