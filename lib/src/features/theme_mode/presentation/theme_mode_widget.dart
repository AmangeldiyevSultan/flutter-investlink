import 'package:flutter/material.dart';
import 'package:investlink/src/features/theme_mode/di/theme_mode_scope.dart';
import 'package:investlink/src/features/theme_mode/presentation/theme_mode_controller.dart';
import 'package:provider/provider.dart';

const _themeByDefault = ThemeMode.system;

class ThemeModeWidget extends StatefulWidget {
  /// {@macro theme_widget.class}
  const ThemeModeWidget({
    required this.child,
    super.key,
  });

  /// Child.
  final Widget child;

  @override
  State<ThemeModeWidget> createState() => _ThemeModeWidgetState();
}

class _ThemeModeWidgetState extends State<ThemeModeWidget> {
  final _themeMode = ValueNotifier<ThemeMode>(_themeByDefault);

  @override
  void initState() {
    super.initState();
    final theme = context.read<IThemeModeScope>().repository.getThemeMode();
    _themeMode.value = theme ?? _themeByDefault;
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ThemeModeController>.value(
      value: ThemeModeControllerImpl(
        themeMode: _themeMode,
        repository: context.read<IThemeModeScope>().repository,
      ),
      child: widget.child,
    );
  }
}
