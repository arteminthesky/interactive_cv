import 'package:flutter/material.dart';
import 'package:interactive_cv/ui/widgets/widgets.dart';

class ImportantAppsPanel extends StatelessWidget {
  const ImportantAppsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RepaintBoundary(
            child: FidgetPanel(
              blurred: true,
              radius: 40,
              child: ColoredBox(
                color: Colors.white24,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 4; i++)
                        const AppIcon(
                          child: Offstage(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
