import 'package:app_base/app_base.dart';

class SiriSuggestions {
  final List<Application> applications;

  SiriSuggestions(this.applications);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SiriSuggestions &&
          runtimeType == other.runtimeType &&
          applications == other.applications;

  @override
  int get hashCode => applications.hashCode;
}
