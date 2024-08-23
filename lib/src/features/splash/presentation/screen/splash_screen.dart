import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/features/auth/presentation/screens/auth_flow.dart';
import 'package:investlink/src/features/pincode/presentation/screens/pincode_flow.dart';
import 'package:investlink/src/features/splash/di/splash_scope.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkIsTokenExist();
  }

  Future<void> _checkIsTokenExist() async {
    try {
      final authPair = await context.read<ISplashScope>().splashRepository.isTokenExist();
      if (authPair?.accessToken != null) {
        if (mounted) {
          context.go(PincodeFlow.routePath);
        }
      } else {
        if (mounted) {
          context.go(AuthFlow.routePath);
        }
      }
    } catch (e) {
      if (mounted) {
        context.go(AuthFlow.routePath);
      }
    }
  }

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
