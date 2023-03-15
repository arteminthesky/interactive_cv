import 'package:app_base/app_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GitHubApplication extends OverlayApplication {
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
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => close(context),
            child: const Text('Close'),
          ),
          middle: const Text('GitHub'),
        ),
        child: Container(),
      ),
    );
  }
}
