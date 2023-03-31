import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:models/models.dart';

class IPhoneWallpaper extends StatelessWidget {
  const IPhoneWallpaper({
    Key? key,
    required this.wallpaper,
  }) : super(key: key);

  final Wallpaper? wallpaper;

  @override
  Widget build(BuildContext context) {
    if (wallpaper == null) return const _IPhoneWallpaperFallback();

    final blurHash = wallpaper?.blurHash;
    return SizedBox.expand(
      child: Image(
        image: AssetImage(wallpaper!.asset),
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        frameBuilder:
            blurHash != null ? _blurHashPlaceholderBuilder(blurHash) : null,
      ),
    );
  }
}

ImageFrameBuilder _blurHashPlaceholderBuilder(String blurHash) {
  return (
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BlurHash(hash: blurHash),
        child,
      ],
    );
  };
}

class _IPhoneWallpaperFallback extends StatelessWidget {
  const _IPhoneWallpaperFallback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
