import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_automation/features/auth/domain/local_storage/local_storage_service.dart';
import 'package:room_automation/features/home/data/model/saved_devices.dart';
import 'package:room_automation/features/switch_screen_page/data/repository/device_repository.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final LocalStorageService localStorageService;
  final DeviceRepository deviceRepository;
  HomeScreenBloc(this.localStorageService, this.deviceRepository)
    : super(HomeScreenInitial()) {
    on<HomeScreenEvent>((event, emit) async {
      switch (event) {
        case FetchSavedDevices():
          await _fetchSavedDevices(event, emit);
        case AddSavedDevices():
          await _addDevices(event, emit);
        case ClearSharedPrefDevices():
          await _clearDevices();
      }
    });
  }

  Future<void> _fetchSavedDevices(
    FetchSavedDevices event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(HomeScreenInitial());
    List<SavedDevices> list = await localStorageService.getDevices();
    if (list.isNotEmpty) {
      emit(DeviceFound(savedDevices: list));
    }
  }

  Future<void> _addDevices(
    AddSavedDevices event,
    Emitter<HomeScreenState> emit,
  ) async {
    List<SavedDevices> list = await localStorageService.getDevices();
    list.addAll(event.list);
    await localStorageService.saveList(event.list);
    deviceRepository.createDeviceIfNotExists(
      deviceId: event.list.first.deviecID,
    );
    add(FetchSavedDevices());
  }

  Future<void> _clearDevices() async {
    await localStorageService.clearList();
    add(FetchSavedDevices());
  }
}
