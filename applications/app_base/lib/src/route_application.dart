import 'package:app_base/app_base.dart';
import 'package:app_base/src/build_application_mixin.dart';
import 'package:app_base/src/splash_screen.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

abstract class RouteApplication extends Application with BuildApplicationMixin {
  Widget _wrapWithHero(BuildContext context) {
    Widget child = SplashScreen(
      appBuilder: buildApp,
      applicationInfo: info,
    );

    final screenRadius = ApplicationHost.screenRadius(context);

    if(screenRadius != null) {
      child = ClipSmoothRect(
        radius: SmoothBorderRadius(
          cornerRadius: screenRadius,
          cornerSmoothing: 0.5,
        ),
        child: child,
      );
    }

    return Hero(
      tag: info.name,
      child: child,
    );
  }

  bool get hero;

  @override
  Future<void> open(BuildContext context, {String? deepLink}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: hero ? _wrapWithHero : buildApp,
      ),
    );
  }
}
