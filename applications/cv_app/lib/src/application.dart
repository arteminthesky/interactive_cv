import 'package:app_base/app_base.dart';
import 'package:cv_app/cv_app.dart';
import 'package:cv_app/src/cv/cv_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CVApplication extends OverlayApplication {
  CVApplication(this.profile);

  final Profile profile;

  @override
  App get appIcon => App(
        'none',
        'CV',
        package: 'cv_app',
      );

  @override
  Widget buildIcon(BuildContext context) {
    return const Center(
      child: Icon(Icons.person),
    );
  }

  @override
  Widget buildApp(BuildContext context) {
    return CupertinoApp(
      home: Provider.value(
        value: profile,
        child: const CvScreen(),
      ),
    );
  }
}
