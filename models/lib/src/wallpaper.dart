class Wallpaper {
  final String asset;

  Wallpaper(this.asset);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Wallpaper &&
          runtimeType == other.runtimeType &&
          asset == other.asset;

  @override
  int get hashCode => asset.hashCode;
}
