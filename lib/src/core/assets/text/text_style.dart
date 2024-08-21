//ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

/// App text style.
enum AppTextStyle {
  regular12(TextStyle(fontSize: 12, height: 1.40)),
  regular14(TextStyle(fontSize: 14, height: 1.40)),
  regular16(TextStyle(fontSize: 16, height: 1.24)),
  regular18(TextStyle(fontSize: 18, height: 1.24)),

  medium14(TextStyle(fontSize: 14, height: 1.40, fontWeight: FontWeight.w500)),
  medium16(TextStyle(fontSize: 16, height: 1.24, fontWeight: FontWeight.w500)),
  medium20(TextStyle(fontSize: 20, height: 1.40, fontWeight: FontWeight.w500)),
  medium26(TextStyle(fontSize: 26, height: 1.40, fontWeight: FontWeight.w500)),
  medium40(TextStyle(fontSize: 40, height: 1.40, fontWeight: FontWeight.w500)),

  bold14(TextStyle(fontSize: 14, height: 1.40, fontWeight: FontWeight.w700)),
  bold16(TextStyle(fontSize: 16, height: 1.24, fontWeight: FontWeight.w700)),
  bold20(TextStyle(fontSize: 20, height: 1.24, fontWeight: FontWeight.w700)),
  bold26(TextStyle(fontSize: 26, height: 1.24, fontWeight: FontWeight.w700)),
  bold32(TextStyle(fontSize: 32, height: 1.24, fontWeight: FontWeight.w700));

  final TextStyle value;

  const AppTextStyle(this.value);
}
