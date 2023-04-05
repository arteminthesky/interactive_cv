import 'package:app_base/app_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_app/src/options/options.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubApplication extends RouteApplication {
  GitHubApplication(this.githubUserName);

  final String githubUserName;

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
      color: Colors.white,
      home: CupertinoPageScaffold(
        backgroundColor: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Coming soon', style: TextStyle(fontSize: 32),),
              const SizedBox(height: 5),
              CupertinoButton(
                color: Colors.white,
                onPressed: () {
                  launchUrl(Uri.parse('https://github.com/$githubUserName'));
                },
                child: const Text('Open GitHub'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  List<Option> get options => [
        OpenAppOption(this),
        OpenLinkOption(githubUserName),
      ];
}
