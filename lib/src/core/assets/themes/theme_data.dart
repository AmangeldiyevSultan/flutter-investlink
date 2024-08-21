import 'package:flutter/material.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/fonts/fonts.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';

/// Class of the app themes data.
abstract class AppThemeData {
  /// Light theme configuration.

  static final lightTheme = ThemeData(
    extensions: [_lightColorScheme, _textTheme],
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        overflow: TextOverflow.clip,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: _lightColorScheme.background,
      onPrimary: _lightColorScheme.background,
      secondary: _lightColorScheme.background,
      onSecondary: _lightColorScheme.background,
      error: _lightColorScheme.danger,
      onError: _lightColorScheme.onDanger,
      surface: _lightColorScheme.background,
      onSurface: _lightColorScheme.defaultIconColor,
      // primary: _lightColorScheme.primary,
      // onPrimary: _lightColorScheme.background,
      // secondary: _lightColorScheme.secondary,
      // onSecondary: _lightColorScheme.onSecondary,
      // error: _lightColorScheme.danger,
      // onError: _lightColorScheme.onDanger,
      // background: _lightColorScheme.background,
      // onBackground: _lightColorScheme.onBackground,
      // surface: _lightColorScheme.surface,
      // onSurface: _lightColorScheme.onSurface,
    ),
    fontFamily: Fonts.sFProDisplay,
    scaffoldBackgroundColor: _lightColorScheme.background,
  );

  /// Dark theme configuration.
  static final darkTheme = ThemeData(
    extensions: [_darkColorScheme, _textTheme],
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        overflow: TextOverflow.clip,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: _darkColorScheme.background,
      onPrimary: _darkColorScheme.background,
      secondary: _darkColorScheme.background,
      onSecondary: _darkColorScheme.background,
      error: _darkColorScheme.danger,
      onError: _darkColorScheme.onDanger,
      surface: _darkColorScheme.elevatedButtonBackgroundColor,
      onSurface: _darkColorScheme.defaultIconColor,
      // onPrimary: _darkColorScheme.elevatedBtnColor,
      // secondary: _darkColorScheme.elevatedBtnColor,
      // onSecondary: _darkColorScheme.onSecondary,
      // error: _darkColorScheme.danger,
      // onError: _darkColorScheme.onDanger,
      // background: _darkColorScheme.background,
      // onBackground: _darkColorScheme.onBackground,
      // surface: _darkColorScheme.surface,
      // onSurface: _darkColorScheme.onSurface,
    ),
    fontFamily: Fonts.sFProDisplay,
    scaffoldBackgroundColor: _darkColorScheme.background,
  );

  static const _lightColorScheme = AppColorScheme.light();
  static const _darkColorScheme = AppColorScheme.dark();
  static final _textTheme = AppTextTheme.base();
}
