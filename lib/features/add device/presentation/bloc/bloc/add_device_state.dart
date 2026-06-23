part of 'add_device_bloc.dart';

sealed class AddDeviceState extends Equatable {
  const AddDeviceState();

  @override
  List<Object> get props => [];
}

class AddDeviceInitial extends AddDeviceState {}

class AddDeviceCheckingWifi extends AddDeviceState {}

class AddDeviceWifiDisabled extends AddDeviceState {}

class AddDeviceScanning extends AddDeviceState {}

class AddDeviceDevicesFound extends AddDeviceState {}

class AddDeviceError extends AddDeviceState {
  final String message;
  const AddDeviceError(this.message);
}
