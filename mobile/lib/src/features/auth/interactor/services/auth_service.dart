import 'package:flutter/material.dart';

import '../states/auth_state.dart';

abstract class AuthService {
  Future<AuthState> checkAuth();

  Future<AuthState> loginWithApple({
    @visibleForTesting bool isWeb = false,
  });

  Future<AuthState> loginWithGoogle({
    @visibleForTesting bool isWeb = false,
  });

  Future<AuthState> logout();
}
