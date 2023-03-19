import 'package:app_base/app_base.dart';
import 'package:flutter/cupertino.dart';

class GmailApplication extends Application {
  @override
  App get appIcon => App(
        'assets/gmail.png',
        'Gmail',
        package: 'gmail',
      );

  @override
  Future<void> open(BuildContext context, {String? deepLink}) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {},
              child: const Text('Send a message'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              isDestructiveAction: true,
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
