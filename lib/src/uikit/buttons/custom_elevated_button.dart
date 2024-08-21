import 'package:flutter/material.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/uikit/text/default_text.dart';

class CtmElevatedButton extends StatelessWidget {
  const CtmElevatedButton({
    required this.onPressed,
    required this.text,
    this.color,
    this.textColor,
    this.borderColor,
    this.child,
    this.padding,
    this.shadowColor = Colors.transparent,
    super.key,
  });

  final VoidCallback onPressed;
  final Color? color;
  final Widget? child;
  final String text;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: padding,
        shadowColor: shadowColor,
        minimumSize: const Size(double.infinity, 56),
        maximumSize: const Size(double.infinity, 56),
        backgroundColor: color ?? AppColorScheme.of(context).elevatedButtonBackgroundColor,
        side: BorderSide(
          width: 2,
          color: borderColor ?? Colors.transparent,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: onPressed,
      child: DText(
        text,
        style: AppTextTheme.of(context).medium16.copyWith(
              color: textColor ?? AppColorScheme.of(context).defaultTextColor,
              overflow: TextOverflow.ellipsis,
            ),
      ),
    );
  }
}
