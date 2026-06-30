import 'package:room_automation/features/switch_screen_page/data/model/DeviceStateModel.dart';

abstract class DeviceRepository {
  Stream<DeviceStateModel> listenDeviceState(
    String deviceId,
  );

  Future<void> updateSwitchState({
    required String deviceId,
    required String switchId,
    required bool state,
  });
}