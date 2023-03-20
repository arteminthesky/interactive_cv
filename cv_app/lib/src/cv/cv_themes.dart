import 'package:flutter/material.dart';

typedef CvThemePreviewBuilder = Widget Function(BuildContext);

const themes = [
  CvThemeData(),
  CvThemeData(
    backgroundColor: Color(0xff440bd4),
    textColor: Color(0xffff2079),
    dividerColor: Color(0xffe92efb),
    cardBackgroundColor: Color(0xff04005e),
  ),
  CvThemeData(
    backgroundColor: Color(0xff282828),
    skillTagTextColor: Color(0xff282828),
    dividerColor: Color(0xff03dac6),
    cardBackgroundColor: Color(0xff121212),
    textColor: Color(0xff32ae85),
  ),
];

class CvThemeData {
  final Color backgroundColor;
  final Color skillTagTextColor;
  final Color textColor;
  final Color cardBackgroundColor;
  final Color dividerColor;
  final CvThemePreviewBuilder? _previewBuilder;

  const CvThemeData({
    this.backgroundColor = Colors.white,
    this.skillTagTextColor = Colors.white,
    this.textColor = Colors.black,
    this.cardBackgroundColor = Colors.white,
    this.dividerColor = Colors.grey,
    CvThemePreviewBuilder? previewBuilder,
  }) : _previewBuilder = previewBuilder;

  CvThemePreviewBuilder get previewBuilder =>
      _previewBuilder ?? (_) => _defaultPreviewBuilder(backgroundColor);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CvThemeData &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          skillTagTextColor == other.skillTagTextColor &&
          textColor == other.textColor &&
          cardBackgroundColor == other.cardBackgroundColor &&
          dividerColor == other.dividerColor &&
          _previewBuilder == other._previewBuilder;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      skillTagTextColor.hashCode ^
      textColor.hashCode ^
      cardBackgroundColor.hashCode ^
      dividerColor.hashCode ^
      _previewBuilder.hashCode;
}

Widget _defaultPreviewBuilder(Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color,
    ),
    alignment: Alignment.center,
  );
}
