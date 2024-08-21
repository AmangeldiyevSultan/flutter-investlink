import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:investlink/src/features/theme_mode/domain/repositories/i_theme_mode_repository.dart';

/// Holds and controls theme mode.
abstract class ThemeModeController {
  /// Current theme mode.
  ValueListenable<ThemeMode> get currentThemeMode;

  /// Set theme mode.
  Future<void> setThemeMode(ThemeMode theme);

  /// Switch theme mode to the opposite.
  Future<void> switchThemeMode();
}

class ThemeModeControllerImpl extends ThemeModeController {
  ThemeModeControllerImpl({
    required ValueNotifier<ThemeMode> themeMode,
    required IThemeModeRepository repository,
  })  : _repository = repository,
        _themeMode = themeMode;

  final ValueNotifier<ThemeMode> _themeMode;

  @override
  ValueListenable<ThemeMode> get currentThemeMode => _themeMode;

  final IThemeModeRepository _repository;

  @override
  Future<void> switchThemeMode() async {
    final newThemeMode = _themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _repository.setThemeMode(_themeMode.value);
    _themeMode.value = newThemeMode;
  }

  @override
  Future<void> setThemeMode(ThemeMode theme) async {
    if (theme == _themeMode.value) return;
    _themeMode.value = theme;
    await _repository.setThemeMode(theme);
  }
}
