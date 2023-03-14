import 'package:flutter/material.dart';
import 'package:models/src/desktop.dart';

class App extends DesktopItem {
  final String icon;
  final int? iconPadding;
  final String name;
  final String? route;
  final Gradient? gradient;
  final Color? imageColor;
  final Color? backgroundColor;

  App(
    this.icon,
    this.name, {
    this.route,
    this.iconPadding,
    this.gradient,
    this.imageColor,
    this.backgroundColor,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is App &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          iconPadding == other.iconPadding &&
          name == other.name &&
          route == other.route &&
          gradient == other.gradient &&
          imageColor == other.imageColor &&
          backgroundColor == other.backgroundColor;

  @override
  int get hashCode =>
      icon.hashCode ^
      iconPadding.hashCode ^
      name.hashCode ^
      route.hashCode ^
      gradient.hashCode ^
      imageColor.hashCode ^
      backgroundColor.hashCode;
}
