import 'package:dandia_driver/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:dandia_driver/features/eanings/presentation/earnings_view.dart';
import 'package:dandia_driver/features/home/presentation/bloc/home_bloc.dart';
import 'package:dandia_driver/features/home/presentation/home_view.dart';
import 'package:dandia_driver/features/profile/presentation/profile_view.dart';
import 'package:dandia_driver/features/trips/presentation/trips_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  static const routeName = '/dashboard';
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeView(),
      const EarningsView(),
      
      const TripsView(),
      const ProfileView(),
    ];

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (context) => HomeBloc(),
            ),
          ],
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.credit_card), label: 'Earnings'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_tree), label: 'Trips'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
              currentIndex: state.selectedIndex,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              enableFeedback: true,
              unselectedItemColor: const Color(0xff718093),
              selectedItemColor: Theme.of(context).colorScheme.onBackground,
              showUnselectedLabels: true,
              onTap: (index) {
                context.read<DashboardBloc>().add(
                      DashboardTabChangedEvent(index: index),
                    );
              },
            ),
            appBar: AppBar(
              title: const Text('DashboardView'),
            ),
            body: pages[state.selectedIndex],
          ),
        );
      },
    );
  }
}
