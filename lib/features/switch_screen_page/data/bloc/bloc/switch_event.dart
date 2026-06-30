part of 'switch_bloc.dart';

sealed class SwitchEvent {}

class StartListening extends SwitchEvent {
  final String deviceId;

  StartListening(this.deviceId);
}

class DeviceStateUpdated extends SwitchEvent {
  final DeviceStateModel state;

  DeviceStateUpdated(this.state);
}

class ToggleSwitchPressed extends SwitchEvent {
  final String switchId;
  final bool newState;

  ToggleSwitchPressed({required this.switchId, required this.newState});
}
