enum PlatformOS {
  macOs,
  linux,
  windows,
  iOS,
  android,
}

abstract class PlatformInfo {
  bool get isWeb;

  bool get isDesktop;

  bool get isMobile;

  PlatformOS get os;
}
