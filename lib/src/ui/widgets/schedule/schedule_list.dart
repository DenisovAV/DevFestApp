import 'package:devfest_flutter_app/src/bloc/data/data_bloc.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:devfest_flutter_app/src/ui/widgets/schedule/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScheduleViewer extends StatelessWidget {
  final String day;

  ScheduleViewer({Key key, this.day})
      : assert(day != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataBloc bloc = BlocProvider.of(context).data;
    Schedule schedule =
        bloc.schedules.firstWhere((schedule) => schedule.date == day);
    return DefaultTabController(
      length: schedule.tracks.length,
      child: Column(
        children: <Widget>[
          TabBar(
              isScrollable: false,
              tabs: schedule.tracks
                  .map((track) => Tab(
                        child: Text(
                          track.title,
                          style: TextStyle(color: Colors.indigo),
                        ),
                      ))
                  .toList()),
          Expanded(
            child: TabBarView(
              children: schedule.tracks
                  .map((track) => ScheduleWidget(track))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
