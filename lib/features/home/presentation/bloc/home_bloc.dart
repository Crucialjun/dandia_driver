import 'dart:async';

import 'package:dandia_driver/core/locator.dart';

import 'package:dandia_driver/services/location_service/i_location_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeInitEvent>(_homeInit);
  }
  final _locationService = locator<ILocationService>();

  FutureOr<void> _homeInit(HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    var res = await _locationService.getCurrentLocation();
    emit(HomeLoaded(res));
  }
}
