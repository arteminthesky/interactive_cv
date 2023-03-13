
import 'package:models/src/desktop.dart';

class App extends DesktopItem {
  final String icon;
  final String name;

  App(this.icon, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is App &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          name == other.name;

  @override
  int get hashCode => icon.hashCode ^ name.hashCode;
}