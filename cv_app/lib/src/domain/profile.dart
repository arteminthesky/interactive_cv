import 'package:json_annotation/json_annotation.dart';

import 'job.dart';

part 'profile.g.dart';

@JsonSerializable(createToJson: false)
class Profile {
  final String name;
  final String? email;
  final String? bio;
  final String? avatar;
  @JsonKey(name: 'github_url')
  final String? githubUrl;
  final String? telegram;
  final String? linkedin;
  final String country;
  final String sex;
  final int age;
  @JsonKey(name: 'work_experience')
  final List<Job>? workExperience;
  final List<String>? skills;

  Profile({
    required this.name,
    required this.country,
    required this.sex,
    required this.age,
    this.email,
    this.bio,
    this.avatar,
    this.githubUrl,
    this.telegram,
    this.linkedin,
    this.workExperience,
    this.skills,
  });

  factory Profile.fromJson(Map<String, Object?> json) => _$ProfileFromJson(json);

  bool get hasContactInformation =>
      telegram != null ||
      linkedin != null ||
      githubUrl != null ||
      email != null;
}
