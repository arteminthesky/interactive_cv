import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iphone_desktop/data/desktops.dart';
import 'package:iphone_desktop/di/di.dart';
import 'package:iphone_desktop/drawers/left_drawer_page.dart';
import 'package:iphone_desktop/drawers/notifications_drawer.dart';
import 'package:iphone_desktop/drawers/right_drawer_page.dart';
import 'package:iphone_desktop/iphone_desktop_page_view.dart';
import 'package:iphone_desktop/widgets/decorations/decorations.dart';
import 'package:iphone_desktop/widgets/decorations/web_decoration.dart';
import 'package:iphone_desktop/window_configuration.dart';
import 'package:models/models.dart';
import 'package:platform_utils/platform_utils.dart' as platform;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WindowConfiguration.apply();
  final essentials = Essentials();
  await essentials.load();
  runApp(MyApp(
    essentials: essentials,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.essentials,
  });

  final Essentials essentials;

  @override
  Widget build(BuildContext context) {
    return AppDecoration(appBuilder: (_, size, safeArea) {
      return Provider.value(
        value: essentials,
        child: Provider<SiriSuggestions>.value(
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
    var essentials = context.watch<Essentials>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: IPhoneDesktopPageView(
        wallpaper: const Wallpaper('assets/wallpapers/wp_1.jpg'),
        desktops: [Desktop(essentials.applications)],
        leftDrawer: const LeftDrawerPage(),
        rightDrawer: const RightDrawerPage(),
        topDrawer: const NotificationsDrawerPage(),
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
