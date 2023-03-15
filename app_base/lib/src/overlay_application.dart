import 'package:app_base/app_base.dart';
import 'package:flutter/widgets.dart';

abstract class OverlayApplication extends Application {

  late final _overlayEntry = OverlayEntry(
    builder: buildApp,
  );

  Widget buildApp(BuildContext context);

  void close() => _overlayEntry.remove();

  @override
  Future<void> open(BuildContext context, {String? deepLink}) {
    Overlay.of(context).insert(_overlayEntry);
    return Future.value();
  }
}
