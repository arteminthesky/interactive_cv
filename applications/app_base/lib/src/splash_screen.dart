import 'package:app_base/app_base.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    required this.applicationInfo,
    required this.appBuilder,
    this.splashBuilder,
  }) : super(key: key);

  final ApplicationInfo applicationInfo;
  final WidgetBuilder? splashBuilder;
  final WidgetBuilder appBuilder;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void>? _delayedFuture;

  @override
  void initState() {
    super.initState();

    _delayedFuture = Future.delayed(
      const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _delayedFuture,
      builder: (context, snapshot) {
        Widget child;
        if (snapshot.connectionState == ConnectionState.done) {
          child = widget.appBuilder(context);
        } else {
          child = Center(
            child: widget.splashBuilder != null
                ? widget.splashBuilder!(context)
                : _defaultSplashBuilder(context, widget.applicationInfo),
          );
        }

        return ColoredBox(
          color: Colors.white,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: child,
          ),
        );
      },
    );
  }
}

Widget _defaultSplashBuilder(BuildContext context, ApplicationInfo info) {
  return Image(
    image: AssetImage(
      info.icon.iconResource,
      package: info.icon.package,
    ),
    width: 80,
    height: 80,
  );
}
