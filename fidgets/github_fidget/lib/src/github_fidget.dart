import 'package:fidget_base/fidget_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_fidget/src/bloc/stats_bloc.dart';
import 'package:github_fidget/src/repository/stats_repository.dart';
import 'package:github_fidget/src/widgets/stats_view.dart';

class GithubFidget extends StatefulWidget {
  const GithubFidget({
    Key? key,
    required this.githubUser,
    required this.repo,
  }) : super(key: key);

  final String githubUser;
  final String repo;

  @override
  State<GithubFidget> createState() => _GithubFidgetState();
}

class _GithubFidgetState extends State<GithubFidget> {
  late final StatsBloc _statsBloc;

  @override
  void initState() {
    super.initState();

    _statsBloc = StatsBloc(
      GithubStatsRepository(),
      widget.githubUser,
      widget.repo,
    )..add(LoadStatsEvent());
  }

  @override
  void dispose() {
    _statsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FidgetPanel(
      aspectRatio: 2,
      blurred: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black45],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.githubUser} | ${widget.repo}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Center(
                  child: BlocBuilder<StatsBloc, StatsState>(
                    bloc: _statsBloc,
                    builder: (context, state) {
                      if (state is StatsLoaded) {
                        return StatsView(stats: state.stats);
                      } else {
                        print(state);
                        return Offstage();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
