import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_automation/features/add%20device/data/repository/wifi_repository.dart';

part 'add_device_event.dart';
part 'add_device_state.dart';

class AddDeviceBloc extends Bloc<AddDeviceEvent, AddDeviceState> {
  final WifiRepository repository;

  AddDeviceBloc(this.repository)
    : super(const AddDeviceState(status: WifiStatus.disabled)) {
    on<CheckWifiStatus>(_onCheckWifiStatus);
    on<EnableWifiPressed>(_onEnableWifiPressed);
    on<StartWifiScan>(_onStartWifiScan);
    on<WifiDevicesFound>(_onWifiDevicesFound);
    on<ClearDevices>(_onClearDevices);
    on<ConnectToDevice>(_onConnectToDevice);
    on<ConfigureDeviceWifi>(_onConfigureDeviceWifi);
  }

  Future<void> _onCheckWifiStatus(
    CheckWifiStatus event,
    Emitter<AddDeviceState> emit,
  ) async {
    try {
      final enabled = await repository.isWifiEnabled();

      if (enabled) {
        emit(state.copyWith(status: WifiStatus.enabled));

        add(StartWifiScan(event.scanAllWiFi));
      } else {
        emit(state.copyWith(status: WifiStatus.disabled, devices: []));
      }
    } catch (e) {
      emit(
        state.copyWith(status: WifiStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onEnableWifiPressed(
    EnableWifiPressed event,
    Emitter<AddDeviceState> emit,
  ) async {
    emit(state.copyWith(status: WifiStatus.enabling));

    await repository.openWifiSettings();
  }

  Future<void> _onStartWifiScan(
    StartWifiScan event,
    Emitter<AddDeviceState> emit,
  ) async {
    emit(state.copyWith(status: WifiStatus.scanning));

    try {
      final devices = await repository.scanDevices(event.scanAllWiFi);

      add(WifiDevicesFound(devices));
    } catch (e) {
      emit(
        state.copyWith(status: WifiStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onWifiDevicesFound(
    WifiDevicesFound event,
    Emitter<AddDeviceState> emit,
  ) async {
    emit(
      state.copyWith(status: WifiStatus.devicesFound, devices: event.devices),
    );
  }

  Future<void> _onClearDevices(
    ClearDevices event,
    Emitter<AddDeviceState> emit,
  ) async {
    emit(state.copyWith(devices: []));
  }

  Future<void> _onConnectToDevice(
    ConnectToDevice event,
    Emitter<AddDeviceState> emit,
  ) async {
    emit(state.copyWith(status: WifiStatus.connecting));

    final success = await repository.connectToDevice(event.ssid);

    if (success) {
      emit(
        state.copyWith(
          status: WifiStatus.connected,
          connectedDevice: event.ssid,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: WifiStatus.error,
          errorMessage: "Failed to connect to ${event.ssid}",
        ),
      );
    }
  }

  Future<void> _onConfigureDeviceWifi(
    ConfigureDeviceWifi event,
    Emitter<AddDeviceState> emit,
  ) async {
    emit(state.copyWith(status: WifiStatus.configuring));

    try {
      await repository.sendWifiCredentials(event.ssid, event.password);

      emit(state.copyWith(status: WifiStatus.configured));
    } catch (e) {
      emit(
        state.copyWith(status: WifiStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
