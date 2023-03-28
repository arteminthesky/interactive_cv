import 'package:app_base/src/models/application_icon.dart';

class ApplicationInfo {
  final ApplicationIcon icon;
  final String name;
  final String description;

  ApplicationInfo({
    required this.icon,
    required this.name,
    required this.description,
  });
}
