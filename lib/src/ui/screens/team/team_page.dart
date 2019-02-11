import 'package:devfest_flutter_app/src/bloc/speakers/speaker_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/speakers/speakers_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/speakers/speakers_bloc_state.dart';
import 'package:devfest_flutter_app/src/bloc/team/team_bloc.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:devfest_flutter_app/src/ui/widgets/info/members_widget.dart';
import 'package:devfest_flutter_app/src/ui/widgets/speakers/speakers_grid.dart';
import 'package:devfest_flutter_app/src/ui/widgets/speakers/speakers_widget.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamPage extends StatefulWidget {
  final TeamRepository repository;
  TeamPage({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  TeamBloc _teamBloc;
  TeamRepository _teamRepository;

  @override
  void initState() {
    _teamRepository = widget.repository;
    _teamBloc = TeamBloc(_teamRepository);
    super.initState();
  }

  @override
  void dispose() {
    _teamBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _teamBloc.teamLoaded,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingWidget();
          } else {
            return TeamMembersWidget(_teamBloc.teams);
          }
        }
    );
  }
}

