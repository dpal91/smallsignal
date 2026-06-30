part of 'home_screen_bloc.dart';

sealed class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

final class HomeScreenInitial extends HomeScreenState {}

class DeviceFound extends HomeScreenState {
  final List<SavedDevices> savedDevices;
  const DeviceFound({required this.savedDevices});
}

DeviceFound copyWith(List<SavedDevices> savedDevices) {
  return DeviceFound(savedDevices: savedDevices);
}
