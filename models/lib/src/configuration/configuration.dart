import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';
import 'package:models/src/configuration/profile/profile.dart';

part 'configuration.g.dart';

@JsonSerializable(createToJson: false)
class ConfigurationBundle {
  @JsonKey(name: 'application_name')
  final String? applicationName;

  @JsonKey(name: 'profile')
  final Profile? profile;

  @JsonKey(name: 'wallpaper')
  final Wallpaper? wallpaper;

  const ConfigurationBundle({
    this.applicationName,
    this.profile,
    this.wallpaper,
  });

  factory ConfigurationBundle.fromJson(Map<String, Object?> json) => _$ConfigurationBundleFromJson(json);
}
