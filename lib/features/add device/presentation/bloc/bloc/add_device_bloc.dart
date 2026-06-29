import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_automation/features/add%20device/data/repository/wifi_repository.dart';

part 'add_device_event.dart';
part 'add_device_state.dart';

class AddDeviceBloc extends Bloc<AddDeviceEvent, AddDeviceState> {
  final WifiRepository repository;
  AddDeviceBloc(this.repository)
    : super(AddDeviceState(status: WifiStatus.disabled)) {
    on<AddDeviceEvent>((event, emit) async {
      switch (event) {
        case CheckWifiStatus():
          await _onCheckStatus(event, emit);
        case EnableWifiPressed():
          await _onEnableWifi(event, emit);
        case StartScan():
          await _onStartScan(event, emit);
        case DevicesDiscovered():
          await _onDevicesFound(event, emit);
      }
    });
  }

  Future<void> _onCheckStatus(
    CheckWifiStatus event,
    Emitter<AddDeviceState> emit,
  ) async {
    final enabled = await repository.isWifiEnabled();

    emit(
      state.copyWith(
        status: enabled ? WifiStatus.enabled : WifiStatus.disabled,
      ),
    );
  }

  Future<void> _onEnableWifi(
    EnableWifiPressed event,
    Emitter<AddDeviceState> emit,
  ) async {
    emit(state.copyWith(status: WifiStatus.enabling));
    await repository.enableWifi();
    emit(state.copyWith(status: WifiStatus.enabled));
    add(StartScan());
  }

  Future<void> _onStartScan(
    StartScan event,
    Emitter<AddDeviceState> emit,
  ) async {
    emit(state.copyWith(status: WifiStatus.scanning));
    final result = await repository.scanDevices();
    result["canScan"]
        ? add(DevicesDiscovered(result["canScan"], result["devices"]))
        : emit(state.copyWith(status: WifiStatus.error));
  }

  Future<void> _onDevicesFound(
    DevicesDiscovered event,
    Emitter<AddDeviceState> emit,
  ) async {
    emit(
      state.copyWith(status: WifiStatus.devicesFound, devices: event.devices),
    );
  }
}
