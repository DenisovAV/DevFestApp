import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/main/main_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/team/team_bloc.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:devfest_flutter_app/src/ui/widgets/info/members_widget.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatefulWidget {
  final Repository repository;
  TeamPage({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  MainBloc _teamBloc;
  Repository _teamRepository;

  @override
  void initState() {
    _teamRepository = widget.repository;
    _teamBloc = MainBloc(_teamRepository);
    super.initState();
  }

  @override
  void dispose() {
    _teamBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocEvent>(
        stream: _teamBloc.teamsStream,
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

