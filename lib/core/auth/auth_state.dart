import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.token,
  });

  final AuthStatus status;
  final String? token;

  AuthState copyWith({
    AuthStatus? status,
    String? token,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState(status: AuthStatus.unknown);

  void setAuthenticated(String token) {
    state = AuthState(status: AuthStatus.authenticated, token: token);
  }

  void setUnauthenticated() {
    state = const AuthState(status: AuthStatus.unauthenticated, token: null);
  }
}

final authStateProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
