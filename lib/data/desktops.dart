

import 'package:models/models.dart';

final apps = [
  App('', 'Calendar'),
  App('', 'Settings'),
  App('assets/apps/github.png', 'GitHub'),
  App('assets/apps/youtube.png', 'YouTube'),
  App('', 'Files'),
  App('', 'Settings'),
  App('', 'Weather'),
  App('assets/apps/camera.png', 'Camera'),
  App('', 'Clock'),
  App('', 'Freeform'),
  App('', 'Calculator'),
  App('', 'Translate'),
  App('', 'Find My'),
  App('', 'Measure'),
  App('', 'Compass'),
  App('', 'Voice Memos'),
  App('', 'Messages'),
  App('', 'Phone'),
  App('', 'Reminders'),
  App('', 'Mail'),
  App('', 'Notes'),
  App('', 'Photos'),
  App('', 'App Store'),
  App('assets/apps/testflight.png', 'TestFlight'),
];

final desktops = [
  Desktop(apps.take(24).toList()),
  Desktop(apps.sublist(5, 10)),
  Desktop(apps.sublist(10, 23)),
];

final siriSuggestions = [
  App('assets/apps/camera.png', 'Camera'),
  App('assets/apps/youtube.png', 'YouTube'),
  App('assets/apps/camera.png', 'Camera'),
];