import 'package:models/models.dart';

class Folder extends DesktopItem {
  final String name;
  final List<App> apps;

  Folder(this.name, this.apps);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Folder &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          apps == other.apps;

  @override
  int get hashCode => name.hashCode ^ apps.hashCode;
}
