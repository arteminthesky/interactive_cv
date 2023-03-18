import 'package:flutter/widgets.dart';
import 'package:iphone_desktop/widgets/decorations/decorations.dart';

class WebDecoration extends StatelessWidget {
  const WebDecoration({Key? key, required this.appBuilder}) : super(key: key);

  final AppBuilder appBuilder;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: IPhone14Decoration(
            appBuilder: appBuilder,
          ),
        ),
      ),
    );
  }
}
