import 'dart:ui';

abstract class WindowManagerBase {
  Future<void> init();

  Future<void>  setWindowSize(Size size);

  Future<void>  hideTitleBar();

  Future<void>  showTitleBar();

  Future<void>  removeFrame();

  Future<void>  setBackgroundColor(Color color);
}
