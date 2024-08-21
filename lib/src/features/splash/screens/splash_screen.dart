import 'package:flutter/material.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorScheme.of(context).background,
      body: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: AppColorScheme.of(context).loaderColor,
          size: 100,
        ),
      ),
    );
  }
}
