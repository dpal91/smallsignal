part of 'login_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class CheckLoginStatus extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

// Registration
class RegisterRequested extends AuthEvent {
  final UserDetails userDetails;

  const RegisterRequested({required this.userDetails});
}
