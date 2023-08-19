import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'data/services/firebase_auth_service.dart';
import 'interactor/reducers/auth_reducer.dart';
import 'interactor/services/auth_service.dart';
import 'ui/pages/login_page.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addInstance<FirebaseAuth>(FirebaseAuth.instance);
    i.addSingleton<GoogleSignIn>(
      () => GoogleSignIn(),
    );
    i.addSingleton<AuthReducer>(AuthReducer.new);
    i.add<AuthService>(FirebaseAuthService.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/login', child: (_) => const LoginPage());
  }
}
