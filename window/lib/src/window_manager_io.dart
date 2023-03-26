import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window/src/window_manager_base.dart';
import 'package:window_manager/window_manager.dart';

WindowManagerBase get windowManagerInstance => IoWindowManager();

class IoWindowManager extends WindowManagerBase {
  @override
  Future<void> init() async {
    if (_isDesktop) {
      await windowManager.ensureInitialized();
      windowManager.waitUntilReadyToShow(
          WindowOptions(backgroundColor: Colors.transparent));
    }
  }

  @override
  Future<void> setWindowSize(Size size) async {
    if (_isDesktop) {
      await Future.wait([
        windowManager.setSize(size),
        windowManager.setResizable(false),
        windowManager.setMinimizable(false),
        windowManager.setMaximizable(false),
      ]);
    }
  }

  @override
  Future<void> hideTitleBar() async {
    if (_isDesktop) {
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    }
  }

  @override
  Future<void> showTitleBar() async {
    if (_isDesktop) {
      await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    }
  }

  @override
  Future<void> removeFrame() async {
    if (_isDesktop) {
      await windowManager.setHasShadow(false);
      await windowManager.setAsFrameless();
    }
  }

  @override
  Future<void> setBackgroundColor(Color color) async {
    if (_isDesktop) {
      await windowManager.setBackgroundColor(color);
    }
  }

  bool get _isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;
}
