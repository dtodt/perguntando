import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perguntando/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:perguntando/src/features/auth/interactor/entities/tokenization.dart';
import 'package:perguntando/src/features/auth/interactor/reducers/auth_reducer.dart';
import 'package:perguntando/src/features/auth/interactor/services/auth_service.dart';
import 'package:perguntando/src/features/auth/interactor/states/auth_state.dart';

class AuthServiceMock extends Mock implements AuthService {}

void main() {
  final service = AuthServiceMock();
  final reducer = AuthReducer(service);

  tearDown(() => reset(service));
  tearDownAll(() => reducer.dispose());

  test('checkAuth', () async {
    when(() => service.checkAuth()).thenAnswer(
      (_) async => const Logged(Tokenization(idToken: 'idToken')),
    );

    expect(
      authState.buffer(2),
      completion([isA<LoadingAuth>(), isA<Logged>()]),
    );

    checkAuthAction();
  });

  test('loginWithApple', () async {
    when(() => service.loginWithApple()).thenAnswer(
      (_) async => const Logged(Tokenization(idToken: 'idToken')),
    );

    expect(
      authState.buffer(2),
      completion([isA<LoadingAuth>(), isA<Logged>()]),
    );

    loginWithAppleAction();
  });

  test('loginWithGoogle', () async {
    when(() => service.loginWithGoogle()).thenAnswer(
      (_) async => const Logged(Tokenization(idToken: 'idToken')),
    );

    expect(
      authState.buffer(2),
      completion([isA<LoadingAuth>(), isA<Logged>()]),
    );

    loginWithGoogleAction();
  });

  test('logout', () async {
    when(() => service.logout()).thenAnswer(
      (_) async => const Unlogged(),
    );

    expect(
      authState.buffer(2),
      completion([isA<LoadingAuth>(), isA<Unlogged>()]),
    );

    logoutAction();
  });
}
