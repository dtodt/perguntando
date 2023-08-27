import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perguntando/src/features/auth/data/services/firebase_auth_service.dart';
import 'package:perguntando/src/features/auth/interactor/services/auth_service.dart';
import 'package:perguntando/src/features/auth/interactor/states/auth_state.dart';

import '../../../../mocks.dart';

void main() {
  final account = GoogleSignInAccountMock();
  final auth = FirebaseAuthMock();
  final authentication = GoogleSignInAuthenticationMock();
  final credential = UserCredentialMock();
  final google = GoogleSignInMock();
  final user = UserMock();

  final AuthService service = FirebaseAuthService(auth, google);

  setUpAll(() {
    registerFallbackValue(AppleAuthProviderMock());
    registerFallbackValue(GoogleAuthProviderMock());
    registerFallbackValue(OAuthCredentialMock());
  });

  tearDown(() {
    reset(account);
    reset(auth);
    reset(authentication);
    reset(credential);
    reset(google);
    reset(user);
  });

  group('checkAuth |', () {
    test('should return logged', () async {
      when(() => auth.currentUser).thenReturn(user);
      when(() => user.getIdToken()).thenAnswer((_) async => 'token');

      final result = await service.checkAuth();
      expect(result, isA<Logged>());
    });

    test('should return unlogged', () async {
      when(() => auth.currentUser).thenReturn(null);

      final result = await service.checkAuth();
      expect(result, isA<Unlogged>());
    });
  });

  group('loginWithApple |', () {
    test('should deal with mobile', () async {
      when(() => auth.signInWithProvider(any()))
          .thenAnswer((_) async => UserCredentialMock());

      when(() => auth.currentUser).thenReturn(user);
      when(() => user.getIdToken()).thenAnswer((_) async => 'token');

      final result = await service.loginWithApple();
      expect(result, isA<Logged>());
    });

    test('should deal with web', () async {
      when(() => auth.signInWithPopup(any()))
          .thenAnswer((_) async => UserCredentialMock());

      when(() => auth.currentUser).thenReturn(user);
      when(() => user.getIdToken()).thenAnswer((_) async => 'token');

      final result = await service.loginWithApple(isWeb: true);
      expect(result, isA<Logged>());
    });
  });

  group('loginWithGoogle |', () {
    test('should deal with mobile', () async {
      when(() => google.signIn()).thenAnswer((_) async => account);
      when(() => account.authentication)
          .thenAnswer((_) async => authentication);
      when(() => authentication.accessToken).thenReturn('accessToken');
      when(() => authentication.idToken).thenReturn('idToken');

      when(() => auth.signInWithCredential(any()))
          .thenAnswer((_) async => UserCredentialMock());

      when(() => auth.currentUser).thenReturn(user);
      when(() => user.getIdToken()).thenAnswer((_) async => 'token');

      final result = await service.loginWithGoogle();
      expect(result, isA<Logged>());
    });

    test('should deal with web', () async {
      when(() => auth.signInWithPopup(any()))
          .thenAnswer((_) async => UserCredentialMock());

      when(() => auth.currentUser).thenReturn(user);
      when(() => user.getIdToken()).thenAnswer((_) async => 'token');

      final result = await service.loginWithGoogle(isWeb: true);
      expect(result, isA<Logged>());
    });
  });

  test('logout should complete', () async {
    when(() => google.isSignedIn()).thenAnswer((_) async => true);
    when(() => google.signOut()).thenAnswer((_) async => account);
    when(() => auth.signOut()).thenAnswer((_) async => {});

    final result = await service.logout();
    expect(result, isA<Unlogged>());
  });
}
