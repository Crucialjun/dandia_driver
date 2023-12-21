part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardTabChangedEvent extends DashboardEvent {
  final int index;

  const DashboardTabChangedEvent({required this.index});

  @override
  List<Object> get props => [index];
}
