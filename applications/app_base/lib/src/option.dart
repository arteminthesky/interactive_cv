import 'package:flutter/cupertino.dart';

/// Describes option available for application
abstract class Option {
  /// Action triggered when user clicks on option
  Future<void> onClick(BuildContext context);

  /// Get name of the option
  String name(BuildContext context);
}
