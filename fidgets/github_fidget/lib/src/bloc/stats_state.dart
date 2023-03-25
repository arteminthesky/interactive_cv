part of 'stats_bloc.dart';

abstract class StatsState {}

class StatsInitial extends StatsState {}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  final Stats stats;

  StatsLoaded(this.stats);

  @override
  String toString() {
    return 'StatsLoaded{stats: $stats}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatsLoaded &&
          runtimeType == other.runtimeType &&
          stats == other.stats;

  @override
  int get hashCode => stats.hashCode;
}

class StatsFailed extends StatsState {
  final Object? error;
  final StackTrace? stackTrace;

  StatsFailed([this.error, this.stackTrace]);

  @override
  String toString() {
    return 'StatsFailed{error: $error, stackTrace: $stackTrace}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatsFailed &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          stackTrace == other.stackTrace;

  @override
  int get hashCode => error.hashCode ^ stackTrace.hashCode;
}
