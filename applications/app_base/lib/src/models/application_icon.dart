
import 'package:flutter/painting.dart';

class ApplicationIcon {
  final String iconResource;
  final String? package;
  final int? padding;
  final Gradient? gradient;
  final Color? imageColor;
  final Color? backgroundColor;

  ApplicationIcon({
    required this.iconResource,
    this.package,
    this.padding,
    this.gradient,
    this.imageColor,
    this.backgroundColor,
  });
}
