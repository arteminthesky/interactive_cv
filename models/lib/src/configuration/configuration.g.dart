// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationBundle _$ConfigurationBundleFromJson(Map<String, dynamic> json) =>
    ConfigurationBundle(
      applicationName: json['application_name'] as String?,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      wallpaper: json['wallpaper'] == null
          ? null
          : Wallpaper.fromJson(json['wallpaper'] as Map<String, dynamic>),
    );
