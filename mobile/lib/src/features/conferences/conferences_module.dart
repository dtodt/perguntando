import 'package:flutter_modular/flutter_modular.dart';

import 'ui/pages/conferences_page.dart';

class ConferencesModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const ConferencesPage());
  }
}
