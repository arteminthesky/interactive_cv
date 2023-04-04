import 'package:app_base/app_base.dart';
import 'package:flutter/cupertino.dart';

const double kDefaultAppIconPadding = 10;

/// Describes logic for the application
abstract class Application {
  const Application();

  /// Description for the application. Includes icon, name, description and other metadata
  abstract final ApplicationInfo info;

  /// The way to open application
  Future<void> open(BuildContext context, {String? deepLink});

  List<Option> get options => [];

  Widget buildIcon(BuildContext context) {
    var icon = info.icon;
    if (icon.iconResource == '') return const Offstage();

    return Padding(
      padding: EdgeInsets.all(
        icon.padding?.toDouble() ?? kDefaultAppIconPadding,
      ),
      child: Image(
        image: AssetImage(icon.iconResource, package: icon.package),
        fit: BoxFit.cover,
        color: icon.imageColor,
        width: 50,
        height: 50,
      ),
    );
  }
}
