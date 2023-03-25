import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/widgets.dart';

class FidgetPanel extends StatelessWidget {
  const FidgetPanel({
    Key? key,
    required this.child,
    this.blurred = true,
    this.radius = 20,
    this.aspectRatio,
  }) : super(key: key);

  final double? aspectRatio;
  final bool blurred;
  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    Widget child = this.child;

    if (blurred) {
      child = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: child,
      );
    }

    child = ClipSmoothRect(
      radius: SmoothBorderRadius(
        cornerRadius: radius,
        cornerSmoothing: 0.5,
      ),
      child: child,
    );

    final safeAspectRatio = aspectRatio;
    if (safeAspectRatio != null) {
      child = AspectRatio(
        aspectRatio: safeAspectRatio,
        child: child,
      );
    }

    return child;
  }
}
