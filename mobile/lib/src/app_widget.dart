import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/auth/interactor/atoms/auth_atoms.dart';
import 'features/auth/interactor/states/auth_state.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late RxDisposer disposer;

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/splash');
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      title: '',
    );
  }

  @override
  void initState() {
    super.initState();

    disposer = rxObserver(() => authState.value, effect: (state) {
      if (state is Unlogged) {
        Modular.to.navigate('/auth/login');
      } else if (state is Logged) {
        Modular.to.navigate('/things/');
      }
    });
  }
}
