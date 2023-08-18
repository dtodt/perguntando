import '../entities/tokenization.dart';

sealed class AuthState {}

class InitAuth implements AuthState {}

class LoadingAuth implements AuthState {}

class Logged implements AuthState {
  final Tokenization token;
  const Logged(this.token);
}

class Unlogged implements AuthState {}
