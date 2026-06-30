import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:room_automation/features/add%20device/data/repository/wifi_Repo_implementation.dart';
import 'package:room_automation/features/add%20device/data/repository/wifi_repository.dart';
import 'package:room_automation/features/auth/data/data_service/firebase_auth_service.dart';
import 'package:room_automation/features/auth/domain/local_storage/local_storage_service.dart';
import 'package:room_automation/features/auth/domain/repositories/auth_repo_impl.dart';
import 'package:room_automation/features/auth/domain/repositories/auth_repository.dart';
import 'package:room_automation/features/switch_screen_page/data/repository/device_repository.dart';
import 'package:room_automation/features/switch_screen_page/data/repository/device_repository_imp.dart';

class Injection {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final LocalStorageService localStorageService = LocalStorageService();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  static final FirebaseAuthService firebaseService = FirebaseAuthService(
    firebaseAuth,
    firestore,
    localStorageService,
  );

  static final AuthRepository authRepository = AuthRepositoryImpl(
    firebaseService,
    localStorageService,
  );

  static final WifiRepository wifiRepository = WifiRepositoryImpl(
    localStorageService,
  );

  static final DeviceRepository deviceRepository = DeviceRepositoryImpl(
    firebaseDatabase,
  );
}
