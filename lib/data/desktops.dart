import 'package:flutter/material.dart';
import 'package:github_app/github_app.dart';
import 'package:linkedin_application/linkedin_application.dart';
import 'package:models/models.dart';

final apps = [
  App('', 'Calendar'),
  App('', 'Settings'),
  App(
    'assets/apps/github.png',
    'GitHub',
    iconPadding: 10,
    imageColor: Colors.white,
    backgroundColor: Colors.black,
  ),
  App('assets/apps/youtube.png', 'YouTube', iconPadding: 10),
  App(
    'assets/apps/linkedin.png',
    'LinkedIn',
    imageColor: Colors.white,
    backgroundColor: Colors.blue,
  ),
  App('', 'Settings'),
  App('', 'Weather'),
  App(
    'assets/apps/camera.png',
    'Camera',
    iconPadding: 10,
    gradient: const LinearGradient(
      colors: [Colors.grey, Colors.white24],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
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

final applications = [
  LinkedInApplication('https://ru.linkedin.com/in/artemparfenov/'),
  GitHubApplication(),
];

final desktops = [
  Desktop(applications),
  Desktop(applications),
];

final siriSuggestions = [
  App('assets/apps/camera.png', 'Camera'),
  App('assets/apps/youtube.png', 'YouTube'),
  App('assets/apps/camera.png', 'Camera'),
];
