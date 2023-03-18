import 'package:flutter/material.dart';
import 'package:iphone_desktop/constants.dart';
import 'package:platform/platform.dart' as platform;
import 'package:window/window.dart';

class WindowConfiguration {
  static Future<void> apply() async {
    await windowManager.init();
    if(platform.instance.isDesktop) {
      await Future.wait([
        windowManager.setWindowSize(kIphone14FrameSize),
        windowManager.hideTitleBar(),
        windowManager.removeFrame(),
        windowManager.setBackgroundColor(Colors.transparent),
      ]);
    }
  }
}