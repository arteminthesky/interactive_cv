import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iphone_desktop/data/desktops.dart';
import 'package:iphone_desktop/iphone_desktop_page_view.dart';
import 'package:iphone_desktop/widgets/decorations/decorations.dart';
import 'package:iphone_desktop/widgets/decorations/web_decoration.dart';
import 'package:iphone_desktop/window_configuration.dart';
import 'package:models/models.dart';
import 'package:platform/platform.dart' as platform;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WindowConfiguration.apply();
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
          color: Colors.transparent,
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
      backgroundColor: Colors.transparent,
      body: IPhoneDesktopPageView(
        wallpaper: Wallpaper('assets/wallpapers/wp_1.jpg'),
        desktops: desktops,
      ),
    );
  }
}

class AppDecoration extends StatelessWidget {
  const AppDecoration({
    Key? key,
    required this.appBuilder,
  }) : super(key: key);

  final AppBuilder appBuilder;

  @override
  Widget build(BuildContext context) {
    final platformInfo = platform.instance;
    if (platformInfo.isDesktop) {
      return IPhone14Decoration(
        appBuilder: appBuilder,
      );
    } else if (platformInfo.isWeb) {
      return WebDecoration(
        appBuilder: appBuilder,
      );
    } else {
      return appBuilder(context, Size.infinite, EdgeInsets.zero);
    }
  }
}
