import 'package:firebase_auth/firebase_auth.dart';

import 'package:room_automation/features/auth/data/entities/user_details.dart';

abstract class AuthRepository {
  Future<UserDetails?> login({required String email, required String password});

  Future<UserDetails?> checkLoginStatus();

  Future<bool> userRegistration({required UserDetails details});

  User? currentUser();

  Future<void> logout();
}
