import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_automation/features/auth/domain/local_storage/local_storage_service.dart';
import 'package:room_automation/features/auth/data/entities/user_details.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final LocalStorageService localStorageService;

  FirebaseAuthService(
    this.firebaseAuth,
    this.firestore,
    this.localStorageService,
  );

  Future<UserDetails?> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    UserDetails user = UserDetails(
      id: credential.user?.uid ?? "",
      name: credential.user?.displayName ?? "",
      email: credential.user?.email ?? "",
      phoneNumber: credential.user?.phoneNumber ?? "",
    );
    if (user.id == "") return null;
    await localStorageService.saveUser(user: jsonEncode(user));

    return user;
  }

  Future<bool> register({required UserDetails details}) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: details.email,
        password: details.password,
      );
      if (credential.user == null) return false;
      if (credential.user?.uid == '') return false;

      //   await firestore.collection('users').doc(credential.user!.uid).set({
      //     'id': credential.user!.uid,
      //     'name': details.name,
      //     'email': details.email,
      //     'phoneNumber': details.phoneNumber,
      //   });

      return true;
    } catch (e) {
      return false;
    }
  }

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
