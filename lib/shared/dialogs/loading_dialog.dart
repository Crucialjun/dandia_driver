import 'package:dandia_driver/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDialog extends StatelessWidget {
  final String message;
  const LoadingDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      backgroundColor: Theme.of(context).colorScheme.surfaceTint,
      child: Container(
          margin: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Padding(
              padding: EdgeInsets.all(15.r),
              child: Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor)),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor),
                  )
                ],
              ))),
    );
  }
}
