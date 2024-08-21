import 'package:flutter/cupertino.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';

class DText extends StatelessWidget {
  const DText(
    this.text, {
    this.style,
    this.textAlign,
    this.maxLines,
    super.key,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      semanticsLabel: text,
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: style ?? AppTextTheme.of(context).regular16,
    );
  }
}
