part of 'add_device_bloc.dart';

sealed class AddDeviceEvent {}

class CheckWifiStatus extends AddDeviceEvent {}

class EnableWifiPressed extends AddDeviceEvent {}

class StartScan extends AddDeviceEvent {}

class DevicesDiscovered extends AddDeviceEvent {
  final bool success;
  final List<String> devices;

  DevicesDiscovered(this.success, this.devices);
}
