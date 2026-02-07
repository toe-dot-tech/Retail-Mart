import 'package:flutter/material.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

class AppTheme {
  static ThemeData get light => ThemeData(


    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.white,
      onSurface: AppColors.textPrimary,
    ),
    scaffoldBackgroundColor: AppColors.white,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
    ),
    //I used the tabbar theme to remove default long line so as to suite the custom ui I wan to create
    tabBarTheme: const TabBarThemeData(
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.textPrimary,
      unselectedLabelColor: Colors.grey,
    ),

    textTheme:  TextTheme(
      headlineLarge: AppTypography.headline1,
      headlineMedium: AppTypography.headline2,
      bodyLarge: AppTypography.body1,
      bodyMedium: AppTypography.body2,
      labelSmall: AppTypography.caption,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTypography.body1,
      ),
    ),
  );
}
