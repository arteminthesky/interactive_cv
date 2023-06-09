import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

@JsonSerializable(createToJson: false)
@DateTimeConverter()
class Job {
  @JsonKey(name: 'company_name')
  final String companyName;

  @JsonKey(name: 'start_date')
  final DateTime? startDate;

  @JsonKey(name: 'end_date', includeIfNull: false)
  final DateTime? endDate;

  @JsonKey(name: 'activity_kind')
  final String? activityKind;

  @JsonKey(name: 'company_logo')
  final String? companyLogo;

  final String? link;

  Job({
    required this.companyName,
    required this.startDate,
    required this.companyLogo,
    required this.link,
    this.endDate,
    this.activityKind,
  });

  factory Job.fromJson(Map<String, Object?> json) => _$JobFromJson(json);
}

class DateTimeConverter
    implements JsonConverter<DateTime?, Map<String, Object?>?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(Map<String, Object?>? json) {
    if (json == null) return null;
    int? year = json['year'] as int?;
    int? month = json['month'] as int?;
    if (month != null && year != null) {
      return DateTime(year, month);
    }
    return null;
  }

  @override
  Map<String, Object?> toJson(DateTime? object) {
    return <String, Object?>{
      'year': object?.year,
      'month': object?.month,
    };
  }
}
