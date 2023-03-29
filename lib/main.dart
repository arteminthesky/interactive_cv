import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interactive_cv/di/di.dart';
import 'package:interactive_cv/drawers/left_drawer_page.dart';
import 'package:interactive_cv/drawers/notifications_drawer.dart';
import 'package:interactive_cv/drawers/right_drawer_page.dart';
import 'package:interactive_cv/iphone_desktop_page_view.dart';
import 'package:interactive_cv/ui/widgets/decorations/decorations.dart';
import 'package:interactive_cv/ui/widgets/decorations/web_decoration.dart';
import 'package:interactive_cv/window_configuration.dart';

import 'package:models/models.dart';
import 'package:platform_utils/platform_utils.dart' as platform;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WindowConfiguration.apply();

  final essentials = Essentials();
  await essentials.load();

  runApp(
    Application(essentials: essentials),
  );
}

class Application extends StatelessWidget {
  const Application({
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
          value: SiriSuggestions([]),
          child: CupertinoApp(
            title: essentials.profile.name,
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
    return IPhoneDesktopPageView(
      wallpaper: const Wallpaper('assets/wallpapers/wp_1.webp'),
      desktops: [Desktop(essentials.applications)],
      leftDrawer: const LeftDrawerPage(),
      rightDrawer: const RightDrawerPage(),
      topDrawer: const NotificationsDrawerPage(),
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
