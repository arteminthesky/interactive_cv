import 'package:app_base/app_base.dart';
import 'package:app_base/src/build_application_mixin.dart';
import 'package:flutter/material.dart';

abstract class RouteApplication extends Application with BuildApplicationMixin {
  Widget _wrapWithHero(BuildContext context) {
    return Hero(
      tag: info.name,
      child: buildApp(context),
    );
  }

  bool get hero;

  @override
  Future<void> open(BuildContext context, {String? deepLink}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: hero ? _wrapWithHero : buildApp),
    );
  }
}
