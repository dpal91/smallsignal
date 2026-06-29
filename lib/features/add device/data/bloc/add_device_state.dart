part of 'add_device_bloc.dart';

enum WifiStatus {
  disabled,
  enabling,
  enabled,
  scanning,
  connecting,
  connected,
  devicesFound,
  error,
  configuring,
  configured,
}


class AddDeviceState {
  final WifiStatus status;
  final List<String> devices;
  final String? errorMessage;
  final String? connectedDevice;

  const AddDeviceState({
    required this.status,
    this.devices = const [],
    this.errorMessage,
    this.connectedDevice,
  });

  AddDeviceState copyWith({
    WifiStatus? status,
    List<String>? devices,
    String? errorMessage,
    String? connectedDevice,
  }) {
    return AddDeviceState(
      status: status ?? this.status,
      devices: devices ?? this.devices,
      errorMessage: errorMessage,
      connectedDevice: connectedDevice ?? this.connectedDevice,
    );
  }
}
