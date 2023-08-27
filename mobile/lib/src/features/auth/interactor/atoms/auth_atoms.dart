import 'package:asp/asp.dart';

import '../states/auth_state.dart';

// atoms
final authState = Atom<AuthState>(const InitAuth(), key: 'authState');

// actions
final checkAuthAction = Atom.action(key: 'checkAuthAction');

final loginWithAppleAction = Atom.action(
  key: 'loginWithAppleAction',
);

final loginWithGoogleAction = Atom.action(
  key: 'loginWithGoogleAction',
);

final logoutAction = Atom.action(key: 'logoutAction');
