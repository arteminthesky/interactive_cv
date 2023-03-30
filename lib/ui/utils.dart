import 'package:flutter/cupertino.dart';

class UiUtils {
  static MediaQueryData combineMediaQuery(
    BuildContext context, {
    Size? screenSize,
    EdgeInsets? safeArea,
  }) {
    var combinedMediaQuery = MediaQuery.of(context);

    if (screenSize != null) {
      combinedMediaQuery = combinedMediaQuery.copyWith(size: screenSize);
    }

    if (safeArea != null) {
      combinedMediaQuery = combinedMediaQuery.copyWith(padding: safeArea);
    }

    return combinedMediaQuery;
  }
}
