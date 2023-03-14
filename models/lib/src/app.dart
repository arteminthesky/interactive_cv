import 'package:models/src/desktop.dart';

class App extends DesktopItem {
  final String icon;
  final int? iconPadding;
  final String name;
  final String? route;

  App(
    this.icon,
    this.name, {
    this.route,
    this.iconPadding,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is App &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          iconPadding == other.iconPadding &&
          name == other.name &&
          route == other.route;

  @override
  int get hashCode =>
      icon.hashCode ^ iconPadding.hashCode ^ name.hashCode ^ route.hashCode;
}
