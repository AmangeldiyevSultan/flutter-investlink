import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/l10n/app_localizations_x.dart';

class CtmTextField extends StatelessWidget {
  const CtmTextField({
    required this.controller,
    this.labelText,
    this.backgroundColor,
    this.suffixIcon,
    this.prefixIcon,
    this.filled = true,
    this.focusNode,
    this.obscureText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.borderColor,
    this.onEditingComplete,
    this.onTap,
    this.hintColor,
    this.maxLine,
    this.minLine,
    this.onTapOutside,
    this.keyboardType,
    this.onChanged,
    this.textAlignVertical,
    this.isDense = true,
    this.contentPadding,
    this.validator,
    this.borderRadius = 8,
    this.focusColor,
    this.maxLength,
    this.cursorHeight,
    this.buildCounter,
    this.hintText,
    this.counter,
    super.key,
  });

  final TextEditingController controller;
  final String? labelText;
  final Color? backgroundColor;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? hintColor;
  final String? hintText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLine;
  final int? minLine;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function()? onEditingComplete;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(PointerDownEvent)? onTapOutside;
  final double? borderRadius;
  final FocusNode? focusNode;
  final Color? focusColor;
  final int? maxLength;
  final double? cursorHeight;
  final bool filled;
  final bool isDense;
  final Widget? counter;
  final TextAlignVertical? textAlignVertical;
  final Widget? Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })? buildCounter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: textAlignVertical,
      controller: controller,
      readOnly: readOnly!,
      cursorHeight: cursorHeight,
      cursorColor: Colors.orangeAccent,
      onTapOutside: onTapOutside ?? (p0) => FocusScope.of(context).unfocus(),
      keyboardType: keyboardType,
      onTap: onTap,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      minLines: minLine ?? 1,
      maxLines: maxLine ?? 1,
      maxLength: maxLength,
      buildCounter: buildCounter,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: borderColor ?? AppColorScheme.of(context).hintColor,
          fontWeight: FontWeight.normal,
        ),
        hintText: hintText ?? labelText,
        hintStyle: TextStyle(
          color: borderColor ?? AppColorScheme.of(context).hintColor,
          fontWeight: FontWeight.normal,
        ),
        counter: counter,
        filled: filled,
        fillColor: backgroundColor ?? AppColorScheme.of(context).textFieldBackground,
        isDense: isDense,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: _CustomUnderlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(
            color: borderColor ?? AppColorScheme.of(context).textFieldBorderColor,
          ),
        ),
        enabledBorder: _CustomUnderlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(
            color: borderColor ?? AppColorScheme.of(context).textFieldBorderColor,
          ),
        ),
        focusedBorder: _CustomUnderlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(
            color: focusColor ?? AppColorScheme.of(context).textFieldBorderColor,
          ),
        ),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return context.l10n.thisFieldIsRequired;
            }
            return null;
          },
    );
  }
}

class _CustomUnderlineInputBorder extends InputBorder {
  const _CustomUnderlineInputBorder({
    this.borderSide = const BorderSide(),
    this.borderRadius = BorderRadius.zero,
  }) : super(borderSide: borderSide);
  // ignore: annotate_overrides, overridden_fields
  final BorderSide borderSide;
  final BorderRadius borderRadius;

  @override
  InputBorder copyWith({BorderSide? borderSide, BorderRadius? borderRadius}) {
    return _CustomUnderlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: borderSide.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius.resolve(textDirection).toRRect(rect).deflate(borderSide.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final paint = borderSide.toPaint();
    final rrect = borderRadius.resolve(textDirection).toRRect(rect);
    canvas.drawRRect(rrect, paint);
  }

  @override
  ShapeBorder scale(double t) {
    return _CustomUnderlineInputBorder(
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  bool get isOutline => false;
}
