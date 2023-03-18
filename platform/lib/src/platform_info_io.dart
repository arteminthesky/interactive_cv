import 'dart:io';

import 'platform_info_base.dart';

class PlatformInfoImpl extends PlatformInfo {
  @override
  bool get isDesktop =>
      Platform.isLinux || Platform.isWindows || Platform.isMacOS;

  @override
  bool get isMobile => Platform.isIOS || Platform.isAndroid;

  @override
  bool get isWeb => false;

  @override
  PlatformOS get os => throw UnimplementedError();
}

