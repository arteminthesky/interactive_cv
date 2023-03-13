import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/widgets.dart';

class IosWidget extends StatelessWidget {
  const IosWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipSmoothRect(
      radius: const SmoothBorderRadius.all(
        SmoothRadius(cornerRadius: 20, cornerSmoothing: 0.5),
      ),
      child: child,
    );
  }
}
