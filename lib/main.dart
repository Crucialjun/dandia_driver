import 'package:dandia_driver/core/app_theme.dart';
import 'package:dandia_driver/core/routes.dart';
import 'package:dandia_driver/features/auth/presentation/sign_in/bloc/signin_bloc.dart';
import 'package:dandia_driver/features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:dandia_driver/services/navigation_service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, child) => MaterialApp(
          onGenerateRoute: (settings) => Routes.generateRoute(settings),
          navigatorKey: NavigationService.navigatorKey,
          scaffoldMessengerKey: NavigationService.snackbarKey,
          title: 'Dandia Driver',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData(Brightness.light),
          darkTheme: AppTheme.themeData(Brightness.dark),
          home: child),
      child: BlocProvider(
        create: (context) => SigninBloc(),
        child: const SignInView(),
      ),
    );
  }
}
