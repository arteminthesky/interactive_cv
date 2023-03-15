import 'package:flutter/material.dart';
import 'package:models/models.dart';

class IPhoneWallpaper extends StatelessWidget {
  const IPhoneWallpaper({
    Key? key,
    required this.wallpaper,
  }) : super(key: key);

  final Wallpaper wallpaper;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image(
        image: AssetImage(wallpaper.asset),
        fit: BoxFit.cover,
      ),
    );
  }
}
