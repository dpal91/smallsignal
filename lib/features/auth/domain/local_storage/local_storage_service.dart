import 'dart:convert';

import 'package:room_automation/features/auth/data/entities/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String userDetailsKey = 'userDetails';
  // static const String uidKey = 'uid';

  Future<void> saveUser({required String user}) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(userDetailsKey, user);
    // await prefs.setString(uidKey, uid);
    print("saved $user");
  }

  Future<UserDetails> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var userJson = prefs.getString(userDetailsKey) ?? "";
    print("user json: " + userJson);
    return userJson != ""
        ? UserDetails.fromJson(jsonDecode(userJson))
        : UserDetails(id: "", name: "", email: "", phoneNumber: "");
  }

  // Future<String?> getEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(emailKey);
  // }

  // Future<String?> getUid() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(uidKey);
  // }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userDetailsKey);
    // await prefs.remove(uidKey);
  }
}
