import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../interactor/entities/tokenization.dart';
import '../../interactor/services/auth_service.dart';
import '../../interactor/states/auth_state.dart';

class FirebaseAuthService extends AuthService {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  FirebaseAuthService(this.auth, this.googleSignIn);

  @override
  Future<AuthState> checkAuth() async {
    final token = await auth.currentUser?.getIdToken();
    if (token == null) {
      return const Unlogged();
    }
    return Logged(Tokenization(idToken: token));
  }

  @override
  Future<AuthState> loginWithApple({
    @visibleForTesting bool isWeb = false,
  }) async {
    final provider = AppleAuthProvider();
    if (kIsWeb || isWeb) {
      await auth.signInWithPopup(provider);
    } else {
      await auth.signInWithProvider(provider);
    }
    return checkAuth();
  }

  @override
  Future<AuthState> loginWithGoogle({
    @visibleForTesting bool isWeb = false,
  }) async {
    if (kIsWeb || isWeb) {
      final provider = GoogleAuthProvider();
      provider.addScope('https://www.googleapis.com/auth/contacts.readonly');

      await auth.signInWithPopup(provider);
    } else {
      final user = await googleSignIn.signIn();
      final authentication = await user?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication?.accessToken,
        idToken: authentication?.idToken,
      );

      await auth.signInWithCredential(credential);
    }

    return checkAuth();
  }

  @override
  Future<AuthState> logout() async {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }

    await auth.signOut();
    return const Unlogged();
  }
}
