import 'package:flutter/material.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingStack extends StatelessWidget {
  const LoadingStack({
    required this.child,
    this.isLoading = false,
    super.key,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          const Opacity(
            opacity: 0.4,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
          Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: AppColorScheme.of(context).loaderColor,
              size: 80,
            ),
          ),
        ],
      ],
    );
  }
}
