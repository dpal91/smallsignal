part of 'add_device_bloc.dart';

sealed class AddDeviceEvent {}

class CheckWifiStatus extends AddDeviceEvent {
  final bool scanAllWiFi;
  CheckWifiStatus(this.scanAllWiFi);
}

class EnableWifiPressed extends AddDeviceEvent {}

class ClearDevices extends AddDeviceEvent {}

class StartWifiScan extends AddDeviceEvent {
  final bool scanAllWiFi;
  StartWifiScan(this.scanAllWiFi);
}

class WifiDevicesFound extends AddDeviceEvent {
  final List<String> devices;

  WifiDevicesFound(this.devices);
}

class ConnectToDevice extends AddDeviceEvent {
  final String ssid;

  ConnectToDevice(this.ssid);
}

class ConfigureDeviceWifi extends AddDeviceEvent {
  final String ssid;
  final String password;

  ConfigureDeviceWifi({required this.ssid, required this.password});
}
