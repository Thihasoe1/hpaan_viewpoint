import 'package:flutter/material.dart';

class CustomFadeInAnimation extends StatelessWidget {
  final Widget child;

  const CustomFadeInAnimation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
