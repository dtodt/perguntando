import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perguntando/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:perguntando/src/features/splash/ui/pages/splash_page.dart';

void main() {
  testWidgets('SplashPage', (tester) async {
    expect(checkAuthAction.next(), completes);

    await tester.pumpWidget(const RxRoot(
      child: MaterialApp(
        home: SplashPage(),
      ),
    ));

    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
