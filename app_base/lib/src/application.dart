import 'package:flutter/cupertino.dart';
import 'package:models/models.dart';

/// Describes logic for the application
abstract class Application {
  /// Description for the application icon
  abstract final App appIcon;

  /// The way to open application
  Future<void> open(BuildContext context, {String? deepLink});
}
