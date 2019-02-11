import 'package:devfest_flutter_app/src/bloc/schedule/schedule_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/schedule/schedule_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/schedule/schedule_bloc_state.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:devfest_flutter_app/src/ui/widgets/schedule/schedule_list.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleRepository repository;
  SchedulePage({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  ScheduleBloc _scheduleBloc;
  ScheduleRepository _scheduleRepository;

  @override
  void initState() {
    _scheduleRepository = widget.repository;
    _scheduleBloc = ScheduleBloc(scheduleRepository: _scheduleRepository);
    _scheduleBloc.dispatch(ScheduleInitiation());
    super.initState();
  }

  @override
  void dispose() {
    _scheduleBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleBloc>(
      bloc: _scheduleBloc,
      child: BlocBuilder<ScheduleEvent, ScheduleState>(
        bloc: _scheduleBloc,
        builder: (BuildContext context, ScheduleState state) {
          if (state is ScheduleInit || state is ScheduleLoading) {
            return LoadingWidget();
          }
          if (state is ScheduleDone) {
            return ScheduleViewer(scheduleBloc: _scheduleBloc, day: '2018-10-27',);
          }
        },
      ),
    );
  }
}

