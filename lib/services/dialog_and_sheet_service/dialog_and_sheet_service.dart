import 'package:dandia_driver/services/dialog_and_sheet_service/i_dialog_and_sheet_service.dart';
import 'package:dandia_driver/services/navigation_service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogAndSheetService extends IDialogAndSheetService {
  final key = NavigationService.navigatorKey;
  final snackbarKey = NavigationService.snackbarKey;
  @override
  Future<T?> showAppBottomSheet<T>(Widget child) async {
    return showModalBottomSheet(
      context: key.currentContext!,
      enableDrag: true,
      isScrollControlled: true,
      elevation: 0,
      isDismissible: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) => child,
    );
  }

  @override
  Future<T?> showAppDialog<T>(Widget child) async {
    return showDialog(
      context: key.currentContext!,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (context) => child,
      barrierDismissible: false,
    );
  }

  @override
  void showSnackBar<T>({required String message}) async {
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
