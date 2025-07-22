import 'package:flutter/material.dart';
import 'package:urban_hunt/config/colors.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: AppColors.light,
    primary: AppColors.primary,
    inverseSurface: AppColors.dark,
  ),
  scaffoldBackgroundColor: AppColors.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.light,
    foregroundColor: AppColors.dark,
    surfaceTintColor: Colors.transparent,
  ),
  primaryColor: AppColors.primary,
  disabledColor: AppColors.disabled,
  fontFamily: 'Roboto Flex',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      height: 1.2,
      fontSize: 28.0,
      color: AppColors.dark,
      fontVariations: [FontVariation.weight(500)],
    ),
    displayMedium: TextStyle(
      height: 1.2,
      fontSize: 24.0,
      color: AppColors.dark,
      fontVariations: [FontVariation.weight(500)],
    ),
    displaySmall: TextStyle(
      height: 1.2,
      fontSize: 20.0,
      color: AppColors.dark,
      fontVariations: [FontVariation.weight(500)],
    ),
    bodyLarge: TextStyle(height: 1.2, fontSize: 18.0, color: AppColors.dark),
    bodyMedium: TextStyle(height: 1.2, fontSize: 16.0, color: AppColors.dark),
    bodySmall: TextStyle(height: 1.2, fontSize: 14.0, color: AppColors.dark),
  ),
  iconTheme: const IconThemeData(color: AppColors.dark, size: 24.0),
  dividerTheme: const DividerThemeData(
    space: 0.0,
    thickness: 1.0,
    color: AppColors.disabled,
  ),
  splashFactory: NoSplash.splashFactory,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.light,
    dragHandleColor: AppColors.disabled,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
  ),
);
