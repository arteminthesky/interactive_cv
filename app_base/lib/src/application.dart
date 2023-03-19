import 'package:flutter/cupertino.dart';
import 'package:models/models.dart';

/// Describes logic for the application
abstract class Application {
  const Application();
  /// Description for the application icon
  abstract final App appIcon;

  /// The way to open application
  Future<void> open(BuildContext context, {String? deepLink});

  Widget buildIcon(BuildContext context) {
    if (appIcon.icon == '') return const Offstage();
    return Padding(
      padding: EdgeInsets.all(appIcon.iconPadding?.toDouble() ?? 0.0),
      child: Image(
        image: AssetImage(appIcon.icon, package: appIcon.package),
        fit: BoxFit.cover,
        color: appIcon.imageColor,
      ),
    );
  }
}
