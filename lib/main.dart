import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iphone_desktop/data/desktops.dart';
import 'package:iphone_desktop/iphone14_decoration.dart';
import 'package:iphone_desktop/iphone_desktop_page_view.dart';
import 'package:models/models.dart';
import 'package:platform/platform.dart' as platform;
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDecoration(appBuilder: (_, size, safeArea) {
      return Provider<SiriSuggestions>.value(
        value: siriSuggestions,
        child: CupertinoApp(
          builder: (context, child) {
            if (size.isInfinite) {
              return child!;
            }
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: size,
                padding: safeArea,
              ),
              child: child!,
            );
          },
          home: const DesktopPage(),
        ),
      );
    });
  }
}

class DesktopPage extends StatefulWidget {
  const DesktopPage({
    super.key,
  });

  @override
  State<DesktopPage> createState() => _DesktopPageState();
}

class _DesktopPageState extends State<DesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IPhoneDesktopPageView(
        wallpaper: Wallpaper('assets/wallpapers/wp_1.jpg'),
        desktops: desktops,
      ),
    );
  }
}

typedef AppBuilder = Widget Function(
  BuildContext context,
  Size size,
  EdgeInsets safeArea,
);

class AppDecoration extends StatelessWidget {
  const AppDecoration({
    Key? key,
    required this.appBuilder,
  }) : super(key: key);

  final AppBuilder appBuilder;

  @override
  Widget build(BuildContext context) {
    final platformInfo = platform.instance;
    if (platformInfo.isWeb) {
      return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white24,
              Colors.black45,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: IPhone14Decoration(
                appBuilder: appBuilder,
              ),
            ),
          ),
        ),
      );
    } else {
      return appBuilder(context, Size.infinite, EdgeInsets.zero);
    }
  }
}
