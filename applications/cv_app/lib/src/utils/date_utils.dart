import 'package:intl/intl.dart';

extension DateExtension on DateTime {

  String formatToMonthWithYear() {
    return DateFormat("MMM yyyy").format(this);
  }
}