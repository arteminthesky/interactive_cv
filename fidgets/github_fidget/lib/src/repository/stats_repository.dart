import 'dart:math';

import 'package:dio/dio.dart';
import 'package:github_fidget/src/model/stats.dart';

abstract class StatsRepository {
  Future<Stats> getStats(String githubUser, String repo);
}

class MockStatsRepository implements StatsRepository {
  @override
  Future<Stats> getStats(String githubUser, String repo) async {
    var random = Random();

    return Stats(List.generate(100, (index) => random.nextInt(15)));
  }
}

class GithubStatsRepository extends StatsRepository {
  @override
  Future<Stats> getStats(String githubUser, String repo) async {
    var result = await Dio().get(
      'https://api.github.com/repos/$githubUser/$repo/stats/participation',
    );

    var body = result.data as Map<String, Object?>;
    var userCommits = body['owner'] as List<Object?>;

    return Stats(userCommits.cast<int>());
  }
}
