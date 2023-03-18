import 'package:window/src/window_manager_base.dart';
import 'package:window/src/window_manager_mock.dart';

WindowManagerBase get windowManagerInstance => WebWindowManager();

class WebWindowManager extends MockWindowManager {}
