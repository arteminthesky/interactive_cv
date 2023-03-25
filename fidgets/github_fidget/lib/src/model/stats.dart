import 'dart:math';

class Stats {
  final List<int> commitsPerWeek;

  Stats(this.commitsPerWeek);

  List<int> getEffectiveWeeks(int weekCount) {
    var effectiveWeeks = <int>[
      ...List.filled(max(0, weekCount - commitsPerWeek.length), 0),
      ...commitsPerWeek.reversed.take(weekCount).toList().reversed,
    ];

    return effectiveWeeks;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stats &&
          runtimeType == other.runtimeType &&
          commitsPerWeek == other.commitsPerWeek;

  @override
  int get hashCode => commitsPerWeek.hashCode;
}
