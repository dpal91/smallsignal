import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_automation/features/auth/data/data_service/firebase_auth_service.dart';
import 'package:room_automation/features/auth/domain/local_storage/local_storage_service.dart';
import 'package:room_automation/features/auth/domain/repositories/auth_repository.dart';
import 'package:room_automation/features/auth/data/entities/user_details.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService firebaseService;
  final LocalStorageService localStorageService;

  AuthRepositoryImpl(this.firebaseService, this.localStorageService);

  @override
  Future<UserDetails?> login({
    required String email,
    required String password,
  }) {
    return firebaseService.signIn(email: email, password: password);
  }

  @override
  Future<UserDetails?> checkLoginStatus() async {
    UserDetails userDetails = await localStorageService.getUser();
    return (userDetails.id == "") ? null : userDetails;
  }

  @override
  User? currentUser() {
    return firebaseService.getCurrentUser();
  }

  @override
  Future<void> logout() {
    return firebaseService.signOut();
  }

  @override
  Future<bool> userRegistration({required UserDetails details}) async{
    return await firebaseService.register(details:  details);
  }
}
