import 'package:cv_app/src/cv/sections/sections.dart';
import 'package:cv_app/src/domain/profile.dart';
import 'package:flutter/material.dart';

class CvWidget extends StatelessWidget {
  const CvWidget({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseInfoSection(profile: profile),
          if (profile.workExperience != null)
            WorkExperienceSection(
              workExperience: profile.workExperience!,
            ),
          if (profile.skills != null)
            SkillsSection(
              skills: profile.skills!,
            ),
        ],
      ),
    );
  }
}
