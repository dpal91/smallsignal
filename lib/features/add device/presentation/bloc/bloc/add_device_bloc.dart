import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_device_event.dart';
part 'add_device_state.dart';

class AddDeviceBloc extends Bloc<AddDeviceEvent, AddDeviceState> {
  AddDeviceBloc() : super(AddDeviceInitial());

  @override
  Stream<AddDeviceState> mapEventToState(
    AddDeviceEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
