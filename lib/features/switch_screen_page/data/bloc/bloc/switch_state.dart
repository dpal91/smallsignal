part of 'switch_bloc.dart';

enum DeviceStatus { initial, loading, loaded, error }

class SwitchState {
  final DeviceStatus status;

  final double voltage;

  final Map<String, bool> switches;

  final String? error;

  const SwitchState({
    this.status = DeviceStatus.initial,
    this.voltage = 0,
    this.switches = const {},
    this.error,
  });

  SwitchState copyWith({
    DeviceStatus? status,
    double? voltage,
    Map<String, bool>? switches,
    String? error,
  }) {
    return SwitchState(
      status: status ?? this.status,
      voltage: voltage ?? this.voltage,
      switches: switches ?? this.switches,
      error: error,
    );
  }
}
