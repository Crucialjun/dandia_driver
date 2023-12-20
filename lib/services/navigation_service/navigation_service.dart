import 'package:dandia_driver/services/navigation_service/i_navigation_service.dart';
import 'package:flutter/material.dart';

class NavigationService implements INavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Future<T?>? navigateToNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  @override
  void back<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }
}
