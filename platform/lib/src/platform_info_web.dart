import 'package:platform/src/platform_info_base.dart';
import 'dart:html';

class PlatformInfoImpl extends PlatformInfo {
  @override
  bool get isDesktop => false;

  @override
  bool get isMobile => false;

  @override
  bool get isWeb => true;

  @override
  PlatformOS get os => throw UnimplementedError();
}
