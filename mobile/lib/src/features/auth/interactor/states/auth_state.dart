import '../entities/tokenization.dart';

sealed class AuthState {}

class InitAuth implements AuthState {
  const InitAuth();
}

class LoadingAuth implements AuthState {
  const LoadingAuth();
}

class Logged implements AuthState {
  final Tokenization token;
  const Logged(this.token);
}

class Unlogged implements AuthState {
  const Unlogged();
}
