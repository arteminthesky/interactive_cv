import 'package:app_base/app_base.dart';

abstract class DesktopItem {}

class Desktop {
  final List<Application> applications;

  const Desktop(this.applications);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Desktop &&
          runtimeType == other.runtimeType &&
          applications == other.applications;

  @override
  int get hashCode => applications.hashCode;
}
