import '../dtos/email_credential.dart';
import '../states/auth_state.dart';

abstract class AuthService {
  Future<AuthState> checkAuth();

  Future<AuthState> loginWithEmail(EmailCredentialDTO dto);

  Future<AuthState> logout();
}
