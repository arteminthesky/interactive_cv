import 'package:app_base/app_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GitHubApplication extends RouteApplication {

  GitHubApplication();

  @override
  ApplicationInfo get info => ApplicationInfo(
    icon: ApplicationIcon(
      iconResource: 'assets/apps/github.png',
      imageColor: Colors.white,
      backgroundColor: Colors.black,
    ),
    name: 'GitHub',
    description: '',
  );

  @override
  bool get hero => true;

  @override
  Widget buildApp(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        child: Scaffold(),
      ),
    );
  }
}
