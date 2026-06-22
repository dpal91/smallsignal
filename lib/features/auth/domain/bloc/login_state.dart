part of 'login_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginAuthenticated extends AuthState {
  final UserDetails user;

  const AuthLoginAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

// class AuthUnauthenticated extends AuthState {}

class AuthLoginError extends AuthState {
  final String message;

  const AuthLoginError(this.message);

  @override
  List<Object?> get props => [message];
}

// Registration
class AuthRegistrationInitial extends AuthState {}

class AuthRegistrationLoading extends AuthState {}

class AuthRegistrationError extends AuthState {
  final String message;
  const AuthRegistrationError(this.message);
}

class AuthRegAuthenticated extends AuthState {
  const AuthRegAuthenticated();
}
