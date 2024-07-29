import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScaleTapper extends StatefulWidget {
  const ScaleTapper({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<ScaleTapper> createState() => _ScaleTapperState();
}

class _ScaleTapperState extends State<ScaleTapper> {
  bool hover = false;
  bool _mounted = true;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: hover ? 0.95 : 1,
      duration: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTapDown: (d) => setState(() => hover = true),
        onTapUp: (d) => setState(() => hover = false),
        onTapCancel: () => setState(() => hover = false),
        onTap: () {
          HapticFeedback.mediumImpact();
          if (_mounted) {
            setState(() => hover = true);
            Future.delayed(const Duration(milliseconds: 100)).then((value) {
              if (_mounted) {
                setState(() => hover = false);
              }
            });
            widget.onTap?.call();
          }
        },
        child: widget.child,
      ),
    );
  }
}
