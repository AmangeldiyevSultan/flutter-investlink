import 'package:flutter/material.dart';
import 'package:investlink/src/core/persistence/theme_storage/i_theme_mode_storage.dart';
import 'package:investlink/src/features/theme_mode/domain/repositories/i_theme_mode_repository.dart';

/// {@template theme_repository.class}
/// Implementation of [IThemeModeRepository].
/// {@endtemplate}
final class ThemeModeRepository implements IThemeModeRepository {
  /// {@macro theme_repository.class}
  ThemeModeRepository({
    required IThemeModeStorage themeModeStorage,
  }) : _themeModeStorage = themeModeStorage;

  final IThemeModeStorage _themeModeStorage;

  @override
  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    await _themeModeStorage.saveThemeMode(mode: newThemeMode);
  }

  @override
  ThemeMode? getThemeMode() {
    return _themeModeStorage.getThemeMode();
  }
}
