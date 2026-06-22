import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_automation/features/auth/data/data_service/firebase_auth_service.dart';
import 'package:room_automation/features/auth/domain/local_storage/local_storage_service.dart';
import 'package:room_automation/features/auth/domain/repositories/auth_repo_impl.dart';
import 'package:room_automation/features/auth/domain/repositories/auth_repository.dart';

class Injection {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final LocalStorageService localStorageService = LocalStorageService();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final FirebaseAuthService firebaseService = FirebaseAuthService(
    firebaseAuth,
    firestore,
    localStorageService,
  );

  static final AuthRepository authRepository = AuthRepositoryImpl(
    firebaseService,
    localStorageService,
  );
}
