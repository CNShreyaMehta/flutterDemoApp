
import 'package:demo_app/presentation/utils/constants/colors.dart';
import 'package:demo_app/presentation/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:demo_app/presentation/utils/theme/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
   TAppTheme._();

static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: TColors.primary,
    secondary: TColors.secondary,
    surface: TColors.surface,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    error: Colors.red,
    onError: Colors.white,
  );

  static final ColorScheme darkColorScheme = ColorScheme.dark(
      primary: TColors.primary1, // Custom Primary Color
    secondary: TColors.secondary1,
    surface: TColors.surface1,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    error: Colors.red[300]!,
    onError: Colors.black,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    //primaryColor: Colors.teal,
    //scaffoldBackgroundColor: Colors.white,
    colorScheme: lightColorScheme,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    //useMaterial3: true,
    //brightness: Brightness.dark,
    //primaryColor: Colors.teal,
    //scaffoldBackgroundColor: Colors.black,
    colorScheme: darkColorScheme,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
  );
}