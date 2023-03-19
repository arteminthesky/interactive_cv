

import 'dart:ui';

import 'package:flutter/widgets.dart';

class NotificationsDrawerPage extends StatelessWidget {
  const NotificationsDrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}
