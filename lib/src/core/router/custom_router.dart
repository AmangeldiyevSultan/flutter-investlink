import 'package:flutter/cupertino.dart';

class FadeTransitionPage<T> extends Page<T> {
  const FadeTransitionPage({
    required this.child,
    this.transitionDuration,
    super.key,
  });
  final Widget child;
  final Duration? transitionDuration;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    );
  }
}

class CupertinoTransitionPage<T> extends Page<T> {
  const CupertinoTransitionPage({
    required this.child,
    this.transitionDuration,
    super.key,
  });
  final Widget child;
  final Duration? transitionDuration;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return CupertinoPageTransition(
          primaryRouteAnimation: animation,
          secondaryRouteAnimation: secondaryAnimation,
          linearTransition: false,
          child: child,
        );
      },
      transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    );
  }
}

class BottomTransitionPage<T> extends Page<T> {
  const BottomTransitionPage({
    required this.child,
    this.transitionDuration,
    super.key,
  });
  final Widget child;
  final Duration? transitionDuration;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.fastOutSlowIn;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    );
  }
}
