import 'package:flutter/material.dart';
import 'package:investlink/src/core/assets/colors/color_palette.dart';

/// App brand color scheme.
///
/// This extension is in sync with base [ThemeData] and [ColorScheme].
///
/// Use case:
///
/// ```dart
/// final colorScheme = CyberdomColorScheme.of(context);
///
/// return Container(color: colorScheme.primary);
/// ```
@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme._({
    required this.background,
    required this.loaderColor,
    required this.defaultTextColor,
    required this.defaultIconColor,
    required this.textFieldBorderColor,
    required this.hintColor,
    required this.textFieldBackground,
    required this.textBlue,
    required this.elevatedButtonBackgroundColor,
    required this.danger,
    required this.onDanger,
    required this.helpBlue,
    required this.failureRed,
    required this.successGreen,
    required this.warningYellow,
    required this.pincodeBorder,
    required this.secondartTextColor,
    required this.greenAccent,
    required this.dividerColor,
  });

  /// Base dark theme version.
  const AppColorScheme.dark()
      : loaderColor = DarkColorPalette.white,
        defaultTextColor = DarkColorPalette.white,
        defaultIconColor = DarkColorPalette.white,
        background = DarkColorPalette.raisinBlack,
        textFieldBorderColor = DarkColorPalette.white,
        hintColor = DarkColorPalette.white,
        textFieldBackground = DarkColorPalette.raisinBlack,
        textBlue = DarkColorPalette.white,
        elevatedButtonBackgroundColor = DarkColorPalette.orangeF3CC50,
        danger = DarkColorPalette.folly,
        onDanger = DarkColorPalette.folly,
        helpBlue = DarkColorPalette.blue3282B8,
        failureRed = DarkColorPalette.redc72c41,
        successGreen = DarkColorPalette.green2D6A4F,
        warningYellow = DarkColorPalette.yellowFCA652,
        pincodeBorder = DarkColorPalette.greyDFE1E8,
        secondartTextColor = DarkColorPalette.purple9191B5,
        greenAccent = DarkColorPalette.green63BE37,
        dividerColor = DarkColorPalette.greyF6F7FA;

  /// Base light theme version.
  const AppColorScheme.light()
      : loaderColor = ColorPalette.orangeAccent,
        defaultTextColor = ColorPalette.black,
        defaultIconColor = ColorPalette.black363F41,
        background = ColorPalette.dirtyWhite,
        textFieldBorderColor = ColorPalette.greyAccent,
        hintColor = ColorPalette.greyB5B5BD,
        textFieldBackground = ColorPalette.white,
        textBlue = ColorPalette.blue4687F3,
        elevatedButtonBackgroundColor = ColorPalette.orangeF3CC50,
        danger = ColorPalette.folly,
        onDanger = ColorPalette.folly,
        helpBlue = ColorPalette.blue3282B8,
        failureRed = ColorPalette.redc72c41,
        successGreen = ColorPalette.green2D6A4F,
        warningYellow = ColorPalette.yellowFCA652,
        pincodeBorder = ColorPalette.greyDFE1E8,
        secondartTextColor = ColorPalette.purple9191B5,
        greenAccent = ColorPalette.green63BE37,
        dividerColor = ColorPalette.greyF6F7FA;

  final Color background;

  final Color loaderColor;

  final Color defaultTextColor;

  final Color defaultIconColor;

  final Color textFieldBorderColor;

  final Color hintColor;

  final Color textFieldBackground;

  final Color textBlue;

  final Color elevatedButtonBackgroundColor;

  final Color danger;

  final Color onDanger;

  /// help
  final Color helpBlue;

  /// failure
  final Color failureRed;

  /// success
  final Color successGreen;

  /// warning
  final Color warningYellow;

  final Color pincodeBorder;

  final Color secondartTextColor;

  final Color greenAccent;

  final Color dividerColor;

  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? background,
    Color? loaderColor,
    Color? defaultTextColor,
    Color? defaultIconColor,
    Color? textFieldBorderColor,
    Color? hintColor,
    Color? textFieldBackground,
    Color? textBlue,
    Color? elevatedButtonBackgroundColor,
    Color? danger,
    Color? onDanger,
    Color? helpBlue,
    Color? failureRed,
    Color? successGreen,
    Color? warningYellow,
    Color? pincodeBorder,
    Color? secondartTextColor,
    Color? greenAccent,
    Color? dividerColor,
  }) {
    return AppColorScheme._(
      background: background ?? this.background,
      loaderColor: loaderColor ?? this.loaderColor,
      defaultTextColor: defaultTextColor ?? this.defaultTextColor,
      defaultIconColor: defaultIconColor ?? this.defaultIconColor,
      textFieldBorderColor: textFieldBorderColor ?? this.textFieldBorderColor,
      hintColor: hintColor ?? this.hintColor,
      textFieldBackground: textFieldBackground ?? this.textFieldBackground,
      textBlue: textBlue ?? this.textBlue,
      elevatedButtonBackgroundColor:
          elevatedButtonBackgroundColor ?? this.elevatedButtonBackgroundColor,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      helpBlue: helpBlue ?? this.helpBlue,
      failureRed: failureRed ?? this.failureRed,
      successGreen: successGreen ?? this.successGreen,
      warningYellow: warningYellow ?? this.warningYellow,
      pincodeBorder: pincodeBorder ?? this.pincodeBorder,
      secondartTextColor: secondartTextColor ?? this.secondartTextColor,
      greenAccent: greenAccent ?? this.greenAccent,
      dividerColor: dividerColor ?? this.dividerColor,
    );
  }

  @override
  ThemeExtension<AppColorScheme> lerp(
    ThemeExtension<AppColorScheme>? other,
    double t,
  ) {
    if (other is! AppColorScheme) {
      return this;
    }

    return AppColorScheme._(
      background: Color.lerp(background, other.background, t)!,
      loaderColor: Color.lerp(loaderColor, other.loaderColor, t)!,
      defaultTextColor: Color.lerp(defaultTextColor, other.defaultTextColor, t)!,
      defaultIconColor: Color.lerp(defaultIconColor, other.defaultIconColor, t)!,
      textFieldBorderColor: Color.lerp(textFieldBorderColor, other.textFieldBorderColor, t)!,
      hintColor: Color.lerp(hintColor, other.hintColor, t)!,
      textFieldBackground: Color.lerp(textFieldBackground, other.textFieldBackground, t)!,
      textBlue: Color.lerp(textBlue, other.textBlue, t)!,
      elevatedButtonBackgroundColor:
          Color.lerp(elevatedButtonBackgroundColor, other.elevatedButtonBackgroundColor, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
      helpBlue: Color.lerp(helpBlue, other.helpBlue, t)!,
      failureRed: Color.lerp(failureRed, other.failureRed, t)!,
      successGreen: Color.lerp(successGreen, other.successGreen, t)!,
      warningYellow: Color.lerp(warningYellow, other.warningYellow, t)!,
      pincodeBorder: Color.lerp(pincodeBorder, other.pincodeBorder, t)!,
      secondartTextColor: Color.lerp(secondartTextColor, other.secondartTextColor, t)!,
      greenAccent: Color.lerp(greenAccent, other.greenAccent, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
    );
  }

  /// Returns [AppColorScheme] from [context].
  static AppColorScheme of(BuildContext context) => Theme.of(context).extension<AppColorScheme>()!;
}
