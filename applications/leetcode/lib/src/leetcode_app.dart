import 'package:app_base/app_base.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeetcodeApplication extends Application {
  final String leetcodeUrl;

  LeetcodeApplication(this.leetcodeUrl);

  @override
  ApplicationInfo get info => ApplicationInfo(
        icon: ApplicationIcon(
          iconResource: 'assets/leetcode.png',
          package: 'leetcode',
          backgroundColor: Colors.black,
        ),
        name: 'Leetcode',
        description: 'Leetcode application',
      );

  @override
  Future<void> open(BuildContext context, {String? deepLink}) {
    return launchUrl(Uri.parse(leetcodeUrl));
  }
}
