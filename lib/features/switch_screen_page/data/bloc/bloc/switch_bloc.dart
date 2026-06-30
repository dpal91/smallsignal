import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:room_automation/features/switch_screen_page/data/model/DeviceStateModel.dart';
import 'package:room_automation/features/switch_screen_page/data/repository/device_repository.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  final DeviceRepository repository;

  StreamSubscription? _subscription;

  String? deviceId;

  SwitchBloc(this.repository) : super(const SwitchState()) {
    on<StartListening>(_onStartListening);

    on<DeviceStateUpdated>(_onDeviceStateUpdated);

    on<ToggleSwitchPressed>(_onToggleSwitchPressed);
  }

  Future<void> _onStartListening(
    StartListening event,
    Emitter<SwitchState> emit,
  ) async {
    deviceId = event.deviceId;

    emit(state.copyWith(status: DeviceStatus.loading));

    await _subscription?.cancel();

    _subscription = repository.listenDeviceState(event.deviceId).listen((data) {
      add(DeviceStateUpdated(data));
    });
  }

  void _onDeviceStateUpdated(
    DeviceStateUpdated event,
    Emitter<SwitchState> emit,
  ) {
    emit(
      state.copyWith(
        status: DeviceStatus.loaded,
        voltage: event.state.voltage,
        switches: event.state.switches,
      ),
    );
  }

  Future<void> _onToggleSwitchPressed(
    ToggleSwitchPressed event,
    Emitter<SwitchState> emit,
  ) async {
    if (deviceId == null) return;

    await repository.updateSwitchState(
      deviceId: deviceId!,
      switchId: event.switchId,
      state: event.newState,
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
