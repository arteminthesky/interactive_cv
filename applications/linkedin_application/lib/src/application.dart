import 'package:app_base/app_base.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkedInApplication extends Application {
  const LinkedInApplication(this.url);

  final String url;

  @override
  Future<void> open(BuildContext context, {String? deepLink}) {
    return launchUrl(
      Uri.parse(url),
    );
  }

  @override
  ApplicationInfo get info => ApplicationInfo(
        icon: ApplicationIcon(
          iconResource: 'assets/apps/linkedin.png',
          imageColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: 4,
        ),
        name: 'LinkedIn',
        description: '',
      );
}
