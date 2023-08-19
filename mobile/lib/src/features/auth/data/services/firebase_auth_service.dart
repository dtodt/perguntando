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
      return Unlogged();
    }
    return Logged(Tokenization(idToken: token));
  }

  @override
  Future<AuthState> loginWithApple() async {
    final provider = AppleAuthProvider();
    if (kIsWeb) {
      await FirebaseAuth.instance.signInWithPopup(provider);
    } else {
      await FirebaseAuth.instance.signInWithProvider(provider);
    }
    return checkAuth();
  }

  @override
  Future<AuthState> loginWithGoogle() async {
    if (kIsWeb) {
      final provider = GoogleAuthProvider();
      provider.addScope('https://www.googleapis.com/auth/contacts.readonly');

      await FirebaseAuth.instance.signInWithPopup(provider);
    } else {
      final user = await googleSignIn.signIn();
      final auth = await user?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth?.accessToken,
        idToken: auth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return checkAuth();
  }

  @override
  Future<AuthState> logout() async {
    if (await googleSignIn.isSignedIn()) {
      googleSignIn.signOut();
    }

    await auth.signOut();
    return Unlogged();
  }
}
