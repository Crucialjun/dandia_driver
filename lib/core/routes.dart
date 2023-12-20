import 'package:dandia_driver/features/auth/presentation/sign_in/bloc/signin_bloc.dart';
import 'package:dandia_driver/features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:dandia_driver/features/auth/presentation/sign_up/bloc/signup_bloc.dart';
import 'package:dandia_driver/features/auth/presentation/sign_up/sign_up_view.dart';
import 'package:dandia_driver/features/dashboard/dashboard_view.dart';
import 'package:dandia_driver/features/home/presentation/bloc/home_bloc.dart';
import 'package:dandia_driver/features/home/presentation/home_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignUpScreen.routeName:
        return _registerBlocView(
            view: const SignUpScreen(), bloc: SignupBloc(), settings: settings);
      case SignInView.routeName:
        return _registerBlocView(
            view: const SignInView(), bloc: SigninBloc(), settings: settings);
      case HomeView.routeName:
        return _registerBlocView(
            view: const HomeView(), bloc: HomeBloc(), settings: settings);
      case DashboardView.routeName:
        return MaterialPageRoute(builder: (_) => const DashboardView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }

  static MaterialPageRoute _registerBlocView<T extends Bloc>({
    required Widget view,
    required T bloc,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => BlocProvider<T>(
        create: (context) => bloc,
        child: view,
      ),
    );
  }
}
