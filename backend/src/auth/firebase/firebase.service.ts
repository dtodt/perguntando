import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';

import { UserEntity } from '@auth/entities';
import * as config from './firebase-config.json';

@Injectable()
export class FirebaseService {
  private readonly app: admin.app.App;

  constructor() {
    this.app = admin.initializeApp({
      credential: admin.credential.cert(config as admin.ServiceAccount),
    });
  }

  async verifyToken(token: string): Promise<UserEntity | null> {
    try {
      const decoded = await this.app.auth().verifyIdToken(token);
      return {
        id: decoded.uid,
        email: decoded.email,
      };
    } catch (error) {
      return null;
    }
  }
}
