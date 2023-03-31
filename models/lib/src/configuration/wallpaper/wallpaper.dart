import 'package:json_annotation/json_annotation.dart';

part 'wallpaper.g.dart';

@JsonSerializable(createToJson: false)
class Wallpaper {
  @JsonKey(name: 'asset')
  final String asset;

  @JsonKey(name: 'blur_hash')
  final String? blurHash;

  const Wallpaper({
    required this.asset,
    this.blurHash,
  });

  factory Wallpaper.fromJson(Map<String, Object?> json) =>
      _$WallpaperFromJson(json);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Wallpaper &&
          runtimeType == other.runtimeType &&
          asset == other.asset &&
          blurHash == other.blurHash;

  @override
  int get hashCode => asset.hashCode ^ blurHash.hashCode;
}
