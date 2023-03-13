abstract class DesktopItem {}

class Desktop {
  final List<DesktopItem> items;

  const Desktop(this.items);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Desktop &&
          runtimeType == other.runtimeType &&
          items == other.items;

  @override
  int get hashCode => items.hashCode;
}
