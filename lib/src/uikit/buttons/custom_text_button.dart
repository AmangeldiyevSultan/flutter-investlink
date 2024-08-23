import 'package:flutter/material.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';

class CtmTextButton extends StatelessWidget {
  const CtmTextButton({
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.shape,
    this.fixedSize,
    this.minimumSize,
    this.maximumSize,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final OutlinedBorder? shape;
  final Size? fixedSize;
  final Size? minimumSize;
  final Size? maximumSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: 0,
        minimumSize: minimumSize,
        maximumSize: maximumSize,
        fixedSize: fixedSize,
        shape: shape,
        backgroundColor: backgroundColor,
        overlayColor: AppColorScheme.of(context).elevatedButtonBackgroundColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
