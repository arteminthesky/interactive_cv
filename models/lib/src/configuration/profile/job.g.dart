// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      companyName: json['company_name'] as String,
      startDate: const DateTimeConverter()
          .fromJson(json['start_date'] as Map<String, Object?>?),
      companyLogo: json['company_logo'] as String?,
      link: json['link'] as String?,
      endDate: const DateTimeConverter()
          .fromJson(json['end_date'] as Map<String, Object?>?),
      activityKind: json['activity_kind'] as String?,
    );
