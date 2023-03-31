import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:models/models.dart';

class IPhoneWallpaper extends StatefulWidget {
  const IPhoneWallpaper({
    Key? key,
    required this.wallpaper,
  }) : super(key: key);

  final Wallpaper? wallpaper;

  @override
  State<IPhoneWallpaper> createState() => _IPhoneWallpaperState();
}

class _IPhoneWallpaperState extends State<IPhoneWallpaper> {
  Future<void>? _imagePrecaching;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final wallpaperAsset = widget.wallpaper?.asset;

    _imagePrecaching ??= wallpaperAsset != null
        ? precacheImage(
            AssetImage(wallpaperAsset),
            context,
          )
        : Future.value();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.wallpaper == null) return const _IPhoneWallpaperFallback();

    final blurHash = widget.wallpaper?.blurHash;

    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (blurHash != null) BlurHash(hash: blurHash),
          FutureBuilder(
            future: _imagePrecaching,
            builder: (context, snapshot) {
              Widget child;

              if (snapshot.connectionState == ConnectionState.done) {
                child = SizedBox.expand(
                  child: Image(
                    image: AssetImage(widget.wallpaper!.asset),
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                child = const Offstage();
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: child,
              );
            },
          ),
        ],
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
