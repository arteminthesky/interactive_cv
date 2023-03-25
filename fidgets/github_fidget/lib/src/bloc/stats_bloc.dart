import 'package:bloc/bloc.dart';
import 'package:github_fidget/src/model/stats.dart';
import 'package:github_fidget/src/repository/stats_repository.dart';

part 'stats_event.dart';

part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc(
    StatsRepository repository,
    this.githubUser,
    this.repo,
  )   : _repository = repository,
        super(StatsInitial()) {
    on<StatsEvent>((event, emit) async {
      emit.call(StatsLoading());

      try {
        final stats = await _repository.getStats(githubUser, repo);

        emit.call(StatsLoaded(stats));
      } on Object catch (e, s) {
        emit.call(StatsFailed(e, s));
      }
    });
  }

  final StatsRepository _repository;
  final String githubUser;
  final String repo;
}
