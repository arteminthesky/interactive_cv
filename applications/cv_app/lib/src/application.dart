import 'package:app_base/app_base.dart';
import 'package:cv_app/src/cv/cv_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:provider/provider.dart';

class CVApplication extends OverlayApplication {
  CVApplication(this.profile);

  final Profile profile;

  @override
  ApplicationInfo get info => ApplicationInfo(
        icon: ApplicationIcon(
          iconResource: '',
          package: 'cv_app',
        ),
        name: 'CV',
        description: '',
      );

  @override
  Widget buildIcon(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.list_alt_rounded,
        size: 40,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildApp(BuildContext context) {
    return CupertinoApp(
      builder: (context, child) {
        var mediaQueryData = ApplicationHost.mediaQuery(context);

        if (mediaQueryData != null) {
          return MediaQuery(data: mediaQueryData, child: child!);
        } else {
          return child!;
        }
      },
      home: Provider.value(
        value: profile,
        child: const CvScreen(),
      ),
    );
  }
}
