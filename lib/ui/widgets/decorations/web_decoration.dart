import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:iphone_desktop/ui/widgets/background.dart';
import 'package:iphone_desktop/ui/widgets/decorations/decorations.dart';

class WebDecoration extends StatelessWidget {
  const WebDecoration({Key? key, required this.appBuilder}) : super(key: key);

  final AppBuilder appBuilder;

  @override
  Widget build(BuildContext context) {
    if(window.physicalSize.aspectRatio < 1) {
      return appBuilder(context, Size.infinite, EdgeInsets.zero);
    }
    return GradientBackground(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: IPhone14Decoration(
              appBuilder: appBuilder,
            ),
          ),
        ),
      ),
    );
  }
}
