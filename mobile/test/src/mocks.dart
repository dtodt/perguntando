import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uno/uno.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class UserMock extends Mock implements User {}

class UserCredentialMock extends Mock implements UserCredential {}

class AppleAuthProviderMock extends Mock implements AppleAuthProvider {}

class GoogleSignInMock extends Mock implements GoogleSignIn {}

class GoogleSignInAccountMock extends Mock implements GoogleSignInAccount {}

class GoogleSignInAuthenticationMock extends Mock
    implements GoogleSignInAuthentication {}

class GoogleAuthProviderMock extends Mock implements GoogleAuthProvider {}

class OAuthCredentialMock extends Mock implements OAuthCredential {}

class ModularNavigateMock extends Mock implements IModularNavigator {}

class ResponseMock extends Mock implements Response {}

class UnoMock extends Mock implements Uno {}
