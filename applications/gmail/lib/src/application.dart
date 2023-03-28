import 'package:app_base/app_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class GmailApplication extends Application {
  GmailApplication(this.email);

  final String email;

  @override
  Future<void> open(BuildContext context, {String? deepLink}) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                launchUrl(Uri.parse('mailto:$email'));
                _close(context);
              },
              child: const Text('Send a message'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => _close(context),
              isDestructiveAction: true,
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  ApplicationInfo get info => ApplicationInfo(
        icon: ApplicationIcon(
          iconResource: 'assets/gmail.png',
          package: 'gmail',
        ),
        name: 'Gmail',
        description: '',
      );
}
