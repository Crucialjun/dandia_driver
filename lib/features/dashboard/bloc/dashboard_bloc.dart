import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<DashboardTabChangedEvent>(_tabChanged);
  }

  FutureOr<void> _tabChanged(DashboardTabChangedEvent event, Emitter<DashboardState> emit) {
    emit(DashboardState(selectedIndex: event.index));
  }
}
