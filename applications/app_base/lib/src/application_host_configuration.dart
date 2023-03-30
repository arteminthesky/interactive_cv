import 'package:flutter/cupertino.dart';

class ApplicationHostConfiguration {
  final MediaQueryData? mediaQueryData;
  final double? screenRadius;

  factory ApplicationHostConfiguration.create({
    required MediaQueryData? mediaQueryData,
    required double? screenRadius,
  }) {
    return ApplicationHostConfiguration._(mediaQueryData, screenRadius);
  }

  ApplicationHostConfiguration._(
    this.mediaQueryData,
    this.screenRadius,
  );
}
