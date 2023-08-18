import '../states/auth_state.dart';

abstract class AuthService {
  Future<AuthState> checkAuth();

  Future<AuthState> loginWithApple();

  Future<AuthState> loginWithGoogle();

  Future<AuthState> logout();
}
