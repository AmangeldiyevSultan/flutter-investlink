import 'package:flutter/material.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';

class CtmCheckBox extends StatelessWidget {
  const CtmCheckBox({required this.value, required this.onChanged, super.key});

  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        activeColor: AppColorScheme.of(context).greenAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        side: BorderSide(
          color: AppColorScheme.of(context).textFieldBorderColor,
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
