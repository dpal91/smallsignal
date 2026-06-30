import 'dart:convert';

import 'package:room_automation/features/auth/data/entities/user_details.dart';
import 'package:room_automation/features/home/data/model/saved_devices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String userDetailsKey = 'userDetails';
  static const String deviceList = 'deviceList';

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

  Future<void> saveList(List<SavedDevices> devices) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> jsonList = devices
        .map((device) => jsonEncode(device.toJson()))
        .toList();

    await prefs.setStringList(deviceList, jsonList);
  }

  Future<List<SavedDevices>> getDevices() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> jsonList = prefs.getStringList(deviceList) ?? [];

    return jsonList
        .map((item) => SavedDevices.fromJson(jsonDecode(item)))
        .toList();
  }

  Future<void> clearList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(deviceList);
  }
}
