import 'package:app_base/src/application_host_configuration.dart';
import 'package:flutter/cupertino.dart';

class _ApplicationHostScope extends InheritedWidget {
  final _ApplicationHostState state;

  const _ApplicationHostScope({
    super.key,
    required this.state,
    required super.child,
  });

  @override
  bool updateShouldNotify(_ApplicationHostScope oldWidget) {
    return oldWidget.state != state;
  }
}

class ApplicationHost extends StatefulWidget {
  const ApplicationHost({
    Key? key,
    required this.child,
    required this.configuration,
  }) : super(key: key);

  final Widget child;
  final ApplicationHostConfiguration configuration;

  @override
  State<ApplicationHost> createState() => _ApplicationHostState();

  static MediaQueryData? mediaQuery(BuildContext context) {
    return maybeOf(context)?.mediaQueryData;
  }

  static double? screenRadius(BuildContext context) {
    return maybeOf(context)?.screenRadius;
  }

  static ApplicationHostConfiguration? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ApplicationHostScope>()
        ?.state
        .widget
        .configuration;
  }
}

class _ApplicationHostState extends State<ApplicationHost> {
  @override
  Widget build(BuildContext context) {
    return _ApplicationHostScope(
      state: this,
      child: widget.child,
    );
  }
}
