part of 'home_screen_bloc.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class FetchSavedDevices extends HomeScreenEvent {}

final class AddSavedDevices extends HomeScreenEvent {
  List<SavedDevices> list;
  AddSavedDevices({required this.list});
}

final class ClearSharedPrefDevices extends HomeScreenEvent {}
