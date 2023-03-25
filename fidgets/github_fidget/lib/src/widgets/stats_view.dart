import 'package:flutter/material.dart';
import 'package:github_fidget/src/widgets/simple_grid.dart';

import '../model/stats.dart';

const _weeksCount = 50;

class StatsView extends StatelessWidget {
  const StatsView({
    Key? key,
    required this.stats,
  }) : super(key: key);

  final Stats stats;

  @override
  Widget build(BuildContext context) {
    final effectiveStatsWeeks = stats.getEffectiveWeeks(_weeksCount);
    assert(effectiveStatsWeeks.length == _weeksCount);

    return SimpleGrid(
      crossAxisCount: 10,
      aspectRatio: 2,
      itemCount: effectiveStatsWeeks.length,
      builder: (context, index) {
        return _StatsCell(count: effectiveStatsWeeks[index]);
      },
    );
  }
}

class _StatsCell extends StatelessWidget {
  const _StatsCell({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _getColorByCount(count),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
      ),
    );
  }

  static Color _getColorByCount(int count) {
    if (count == 0) return Colors.white30;
    if (count < 5) return Colors.lightGreenAccent;
    if (count < 10) return Colors.lightGreen;
    return Colors.green;
  }
}
