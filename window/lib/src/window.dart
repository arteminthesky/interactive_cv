import 'package:window/src/window_manager_base.dart';

import 'window_manager_mock.dart'
    if (dart.library.io) 'window_manager_io.dart'
    if (dart.library.html) 'window_manager_web.dart';

WindowManagerBase get windowManager => windowManagerInstance;
