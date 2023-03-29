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
    required this.mediaQueryData,
  }) : super(key: key);

  final Widget child;
  final MediaQueryData mediaQueryData;

  @override
  State<ApplicationHost> createState() => _ApplicationHostState();

  static MediaQueryData mediaQuery(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ApplicationHostScope>()!
        .state
        .widget
        .mediaQueryData;
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
