import 'package:asp/asp.dart';

import '../atoms/auth_atoms.dart';
import '../services/auth_service.dart';
import '../states/auth_state.dart';

class AuthReducer extends Reducer {
  final AuthService service;

  AuthReducer(this.service) {
    on(() => [checkAuthAction], _checkAuth);
    on(() => [loginWithAppleAction], _loginWithApple);
    on(() => [loginWithGoogleAction], _loginWithGoogle);
    on(() => [logoutAction], _logout);
  }

  void _checkAuth() {
    authState.value = LoadingAuth();
    service.checkAuth().then(authState.setValue);
  }

  void _loginWithApple() {
    authState.value = LoadingAuth();
    service.loginWithApple().then(authState.setValue);
  }

  void _loginWithGoogle() {
    authState.value = LoadingAuth();
    service.loginWithGoogle().then(authState.setValue);
  }

  void _logout() {
    authState.value = LoadingAuth();
    service.logout().then(authState.setValue);
  }
}
