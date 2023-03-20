import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iphone_desktop/constants.dart';
import 'package:platform_utils/platform_utils.dart' as platform;
import 'package:window/window.dart';

class WindowConfiguration {
  static Future<void> apply() async {
    await windowManager.init();
    if (platform.instance.isDesktop) {
      await Future.wait([
        windowManager.setWindowSize(kIphone14FrameSize),
        windowManager.hideTitleBar(),
        windowManager.removeFrame(),
        windowManager.setBackgroundColor(Colors.transparent),
      ]);
    } else if (platform.instance.isMobile) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
        SystemUiOverlay.bottom,
      ]);
    }
  }
}
