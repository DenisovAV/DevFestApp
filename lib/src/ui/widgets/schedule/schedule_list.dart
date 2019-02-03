import 'package:devfest_flutter_app/src/bloc/schedule/schedule_bloc.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/ui/widgets/schedule/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ScheduleViewer extends StatelessWidget {
  final ScheduleBloc scheduleBloc;
  final String day;

  ScheduleViewer({Key key, @required this.scheduleBloc, @required this.day})
      : assert(scheduleBloc != null),
      assert(day != null),
      super(key: key);


  @override
  Widget build(BuildContext context) {
    Schedule s=scheduleBloc.schedule.firstWhere((schedule)=>schedule.date==day);
    return DefaultTabController(
            length: scheduleBloc.schedule.firstWhere((schedule)=>schedule.date==day).tracks.length,
            child: Column(
              children: <Widget>[
                TabBar(
                    isScrollable: false,
                    tabs: s.tracks
                        .map((track) => Tab(
                              child: Text(
                                track.title,
                                style: TextStyle(color: Colors.indigo),
                              ),
                            ))
                        .toList()),
                Expanded(
                  child: TabBarView(
                    children:
                        s.tracks.map((track) => ScheduleWidget(track)).toList(),
                  ),
                )
              ],
            ),
          );

  }
}
