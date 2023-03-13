import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iphone_desktop/data/desktops.dart';
import 'package:iphone_desktop/iphone_desktop_page_view.dart';
import 'package:models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: DesktopPage(),
    );
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
