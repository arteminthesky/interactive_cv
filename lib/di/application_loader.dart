import 'package:app_base/app_base.dart';
import 'package:cv_app/cv_app.dart';
import 'package:github_app/github_app.dart';
import 'package:gmail/gmail.dart';
import 'package:linkedin_application/linkedin_application.dart';

abstract class ApplicationLoader {
  Future<List<Application>> load(Profile profile);
}

typedef ApplicationCreator = Application? Function(Profile profile);

class BaseApplicationLoader extends ApplicationLoader {
  @override
  Future<List<Application>> load(Profile profile) async {
    final applications = <Application>[];

    var applicationLoaders = <ApplicationCreator>[
      _createCvApp,
      _ensureCreateGithub,
      _ensureCreateLinkedInApp,
      _ensureCreateGmail,
    ];

    for (final applicationLoader in applicationLoaders) {
      final application = applicationLoader(profile);
      if (application != null) {
        applications.add(application);
      }
    }

    return applications;
  }

  Application _createCvApp(Profile profile) {
    return CVApplication(profile);
  }

  Application? _ensureCreateGithub(Profile profile) {
    if (profile.githubUrl != null) {
      return GitHubApplication();
    }
    return null;
  }

  Application? _ensureCreateLinkedInApp(Profile profile) {
    if (profile.linkedin != null) {
      return LinkedInApplication(profile.linkedin!);
    }
    return null;
  }

  Application? _ensureCreateGmail(Profile profile) {
    if (profile.email != null) {
      return GmailApplication(profile.email!);
    }
    return null;
  }
}
