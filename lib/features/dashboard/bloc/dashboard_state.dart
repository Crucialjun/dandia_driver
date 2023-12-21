part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final int selectedIndex;
  const DashboardState({this.selectedIndex = 0});

  @override
  List<Object> get props => [selectedIndex];

  //copy with
  DashboardState copyWith({
    int? selectedIndex,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

final class DashboardInitial extends DashboardState {}
