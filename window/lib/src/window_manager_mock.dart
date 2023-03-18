import 'dart:ui';

import 'package:window/src/window_manager_base.dart';

WindowManagerBase get windowManagerInstance => MockWindowManager();

class MockWindowManager extends WindowManagerBase {
  @override
  Future<void> setWindowSize(Size size) async {}

  @override
  Future<void> init() async {}

  @override
  Future<void> hideTitleBar() async {}

  @override
  Future<void> showTitleBar() async {}

  @override
  Future<void> removeFrame() async {}

  @override
  Future<void> setBackgroundColor(Color color) async {}
}
