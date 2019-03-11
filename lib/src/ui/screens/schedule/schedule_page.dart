import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/bloc/data/data_bloc.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:devfest_flutter_app/src/ui/widgets/schedule/schedule_list.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataBloc bloc = BlocProvider.of(context).data;
    return StreamBuilder<BlocEvent>(
        stream: bloc.schedulesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            bloc.checkRepo(SchedulesLoadedEvent());
            return LoadingWidget();
          } else {
            return ScheduleViewer(day: '2018-10-27',);
          }
        }
    );
  }
}



