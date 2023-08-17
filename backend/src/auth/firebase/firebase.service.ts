import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';

import * as config from './firebase-config.json';

@Injectable()
export class FirebaseService {
  private readonly app: admin.app.App;

  constructor() {
    this.app = admin.initializeApp({
      credential: admin.credential.cert(config as admin.ServiceAccount),
    });
  }

  async verifyToken(token: string): Promise<boolean> {
    try {
      await this.app.auth().verifyIdToken(token);
      return true;
    } catch (error) {
      return false;
    }
  }
}
