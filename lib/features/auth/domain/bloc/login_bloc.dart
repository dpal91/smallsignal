import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_automation/features/auth/domain/repositories/auth_repository.dart';
import 'package:room_automation/features/auth/data/entities/user_details.dart';

part 'login_event.dart';
part 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case LoginRequested():
          await _loginRequested(event, emit);
        case CheckLoginStatus():
          _checkLoginStatus();
        case LogoutRequested():
          _logoutRequested();
        case RegisterRequested():
          await _onRegistrationRequisted(event, emit);
      }
    });
  }

  Future<void> _loginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await repository.login(
        email: event.email,
        password: event.password,
      );

      if (user != null) {
        emit(AuthLoginAuthenticated(user));
      } else {
        emit(const AuthLoginError("Login failed"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthLoginError(e.code));
    } catch (e) {
      emit(AuthLoginError(e.toString()));
    }
  }

  void _checkLoginStatus() async {
    UserDetails? user = await repository.checkLoginStatus();
    print("user: " + user.toString());
    if (user == null) {
      emit(AuthInitial());
      return;
    }
    if (user?.id != "") {
      emit(AuthLoginAuthenticated(user!));
      return;
    }
  }

  void _logoutRequested() {}

  Future<void> _onRegistrationRequisted(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthRegistrationLoading());

      var rest = await repository.userRegistration(details: event.userDetails);
      emit(
        rest
            ? AuthRegAuthenticated()
            : AuthRegistrationError("Some Error occurred"),
      );
    } catch (e) {
      emit(AuthRegistrationError(e.toString()));
    }
  }
}
