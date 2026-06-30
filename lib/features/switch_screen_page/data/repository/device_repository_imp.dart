import 'package:firebase_database/firebase_database.dart';
import 'package:room_automation/features/switch_screen_page/data/model/DeviceStateModel.dart';
import 'package:room_automation/features/switch_screen_page/data/repository/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final FirebaseDatabase database;

  DeviceRepositoryImpl(this.database);

  @override
  Stream<DeviceStateModel> listenDeviceState(String deviceId) {
    return database.ref("devices/$deviceId").onValue.map((event) {
      final value = event.snapshot.value;

      if (value == null) {
        return DeviceStateModel.defaultState();
      }

      return DeviceStateModel.fromJson(
        Map<dynamic, dynamic>.from(value as Map),
      );
    });
  }

  @override
  Future<void> updateSwitchState({
    required String deviceId,
    required String switchId,
    required bool state,
  }) async {
    await database.ref("devices/$deviceId/switches/$switchId").set(state);
  }

  @override
  Future<void> createDeviceIfNotExists({required String deviceId}) async {
    final ref = database.ref("devices/$deviceId");
    final snapshot = await ref.get();
    if (!snapshot.exists) {
      await ref.set({
        "voltage": 0,
        "switches": {
          "Switch 1": false,
          "Switch 2": false,
          "Switch 3": false,
          "Switch 4": false,
        },
      });
    }
  }
}
