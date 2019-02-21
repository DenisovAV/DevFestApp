import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/main/main_bloc.dart';
import 'package:devfest_flutter_app/src/ui/widgets/schedule/schedule_list.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  final MainBloc bloc;

  SchedulePage(this.bloc, {Key key})
      : assert(bloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocEvent>(
        stream: bloc.schedulesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            bloc.checkRepo(SchedulesLoadedEvent());
            return LoadingWidget();
          } else {
            return ScheduleViewer(bloc, day: '2018-10-27',);
          }
        }
    );
  }
}



