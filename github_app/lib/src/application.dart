import 'package:app_base/app_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GitHubApplication extends OverlayApplication {

  GitHubApplication();

  @override
  App get appIcon => App(
        'assets/apps/github.png',
        'GitHub',
        imageColor: Colors.white,
        backgroundColor: Colors.black,
        iconPadding: 10,
      );

  @override
  Widget buildApp(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('GitHub'),
        ),
        child: Scaffold(),
      ),
    );
  }
}
