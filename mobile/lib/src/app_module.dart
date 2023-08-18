import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/auth/auth_module.dart';
import 'features/conferences/conferences_module.dart';
import 'features/splash/ui/pages/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance<FirebaseAuth>(FirebaseAuth.instance);
  }

  @override
  List<Module> get imports => [
        AuthModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child('/splash', child: (_) => const SplashPage());
    r.module('/conferences', module: ConferencesModule());
    r.module('/auth', module: AuthModule());
  }
}
