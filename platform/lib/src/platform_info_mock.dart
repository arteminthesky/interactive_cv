import 'package:platform/src/platform_info_base.dart';

class PlatformInfoImpl extends PlatformInfo {
  @override
  bool get isDesktop => throw UnimplementedError();

  @override
  bool get isMobile => throw UnimplementedError();

  @override
  bool get isWeb => throw UnimplementedError();

  @override
  PlatformOS get os => throw UnimplementedError();
}
