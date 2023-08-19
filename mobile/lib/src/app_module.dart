import 'package:flutter_modular/flutter_modular.dart';
import 'package:uno/uno.dart';

import 'core/constants.dart';
import 'features/auth/auth_module.dart';
import 'features/auth/interactor/atoms/auth_atoms.dart';
import 'features/auth/interactor/states/auth_state.dart';
import 'features/conferences/conferences_module.dart';
import 'features/splash/ui/pages/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<Uno>(() {
      final uno = Uno(
        baseURL: apiUrl,
      );
      uno.interceptors.request.use(resolveRequest);
      return uno;
    });
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

  Request resolveRequest(Request request) {
    final state = authState.value;
    if (state is Logged) {
      final token = state.token;
      request.headers['Authorization'] = 'Bearer $token';
    }
    return request;
  }
}
