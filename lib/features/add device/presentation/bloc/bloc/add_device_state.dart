part of 'add_device_bloc.dart';

enum WifiStatus { disabled, enabling, enabled, scanning, devicesFound, error }

class AddDeviceState {
  final WifiStatus status;
  final List<String> devices;

  AddDeviceState({required this.status, this.devices = const []});

  AddDeviceState copyWith({WifiStatus? status, List<String>? devices}) {
    return AddDeviceState(
      status: status ?? this.status,
      devices: devices ?? this.devices,
    );
  }
}
