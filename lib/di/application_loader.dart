import 'package:app_base/app_base.dart';
import 'package:cv_app/cv_app.dart';
import 'package:github_app/github_app.dart';
import 'package:gmail/gmail.dart';
import 'package:leetcode/leetcode.dart';
import 'package:linkedin_application/linkedin_application.dart';
import 'package:models/models.dart';

abstract class ApplicationLoader {
  Future<List<Application>> load(ConfigurationBundle bundle);
}

typedef ApplicationCreator = Application? Function(ConfigurationBundle bundle);

class BaseApplicationLoader extends ApplicationLoader {
  @override
  Future<List<Application>> load(ConfigurationBundle bundle) async {
    final applications = <Application>[];

    var applicationLoaders = <ApplicationCreator>[
      _createCvApp,
      _ensureCreateGithub,
      _ensureCreateLinkedInApp,
      _ensureCreateGmail,
      _ensureCreateLeetcode,
    ];

    for (final applicationLoader in applicationLoaders) {
      final application = applicationLoader(bundle);
      if (application != null) {
        applications.add(application);
      }
    }

    return applications;
  }

  Application? _createCvApp(ConfigurationBundle bundle) {
    final profile = bundle.profile;
    if(profile != null) {
      return CVApplication(profile);
    }
    return null;
  }

  Application? _ensureCreateGithub(ConfigurationBundle bundle) {
    final github = bundle.profile?.githubUrl;
    if (github != null) {
      return GitHubApplication(github);
    }
    return null;
  }

  Application? _ensureCreateLinkedInApp(ConfigurationBundle bundle) {
    final linkedin = bundle.profile?.linkedin;
    if (linkedin != null) {
      return LinkedInApplication(linkedin);
    }
    return null;
  }

  Application? _ensureCreateGmail(ConfigurationBundle bundle) {
    final email = bundle.profile?.email;
    if (email != null) {
      return GmailApplication(email);
    }
    return null;
  }

  Application? _ensureCreateLeetcode(ConfigurationBundle bundle) {
    final leetcode = bundle.profile?.leetcode;
    if(leetcode != null) {
      return LeetcodeApplication(leetcode);
    }
    return null;
  }
}
