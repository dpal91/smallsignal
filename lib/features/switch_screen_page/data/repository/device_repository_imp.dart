import 'package:firebase_database/firebase_database.dart';
import 'package:room_automation/features/switch_screen_page/data/model/DeviceStateModel.dart';
import 'package:room_automation/features/switch_screen_page/data/repository/device_repository.dart';

class DeviceRepositoryImpl
    implements DeviceRepository {

  final FirebaseDatabase database;

  DeviceRepositoryImpl(this.database);

  @override
  Stream<DeviceStateModel> listenDeviceState(
    String deviceId,
  ) {
    return database
        .ref("devices/$deviceId")
        .onValue
        .map(
          (event) => DeviceStateModel.fromJson(
            event.snapshot.value
                as Map<dynamic, dynamic>,
          ),
        );
  }

  @override
  Future<void> updateSwitchState({
    required String deviceId,
    required String switchId,
    required bool state,
  }) async {
    await database.ref(
      "devices/$deviceId/switches/$switchId",
    ).set(state);
  }
}