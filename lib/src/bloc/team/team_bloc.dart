import 'dart:async';

import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/models/team.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';

class TeamBloc {
  final TeamRepository teamRepository;
  List<Team> teams = List<Team>();
  final teamController = StreamController<BlocEvent>();
  Stream<BlocEvent> get teamLoaded => teamController.stream;

  TeamBloc(this.teamRepository) : assert(teamRepository != null) {
    init();
  }

  init() {
    teamRepository.getTeams().listen(_onTeamsLoaded);
  }

  _onTeamsLoaded(List<Team> teams) {
    this.teams = teams;
    this.teams
        .forEach((team) => teamRepository.getMembers(team.id).listen((members) {
              team.members = members;
              teamController.sink.add(TeamLoadedEvent());
            }));
  }

  void dispose() {
    teamController?.close();
  }
}
