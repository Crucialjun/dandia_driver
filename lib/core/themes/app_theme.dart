import 'package:dandia_driver/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeData(Brightness brightness) => ThemeData(
        fontFamily: GoogleFonts.nunitoSans().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          brightness: brightness,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: brightness == Brightness.light
              ? AppColors.lightScaffoldBackgroundColor
              : AppColors.darkScaffoldBackgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: brightness == Brightness.light
              ? AppColors.lightScaffoldBackgroundColor
              : AppColors.darkScaffoldBackgroundColor,
          shadowColor: brightness == Brightness.light
              ? AppColors.lightScaffoldBackgroundColor
              : AppColors.darkScaffoldBackgroundColor,
          iconTheme: IconThemeData(
            color: brightness == Brightness.light
                ? AppColors.darkScaffoldBackgroundColor
                : AppColors.lightScaffoldBackgroundColor,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: brightness == Brightness.light
                ? AppColors.lightScaffoldBackgroundColor
                : AppColors.darkScaffoldBackgroundColor,

            // Status bar brightness (optional)
            statusBarIconBrightness: brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light, // For Android (dark icons)
            statusBarBrightness: brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light, // For iOS
          ),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: brightness == Brightness.light
            ? AppColors.lightScaffoldBackgroundColor
            : AppColors.darkScaffoldBackgroundColor,
      );
}
