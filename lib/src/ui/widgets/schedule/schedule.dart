import 'package:devfest_flutter_app/src/bloc/main/main_bloc.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/ui/widgets/schedule/session_widget.dart';
import 'package:devfest_flutter_app/src/models/session.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/utils/colors.dart';
import 'package:flutter/material.dart';

class ScheduleWidget extends StatefulWidget {
  _SingleScheduleWidgetState createState() => _SingleScheduleWidgetState(track, bloc);
  final Track track;
  final MainBloc bloc;
  ScheduleWidget(this.track, this.bloc);
}

class _SingleScheduleWidgetState extends State<ScheduleWidget> {
  final Track track;
  final MainBloc bloc;
  _SingleScheduleWidgetState(this.track, this.bloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: new ListView.builder(
        itemCount: track.timeslots.length,
        padding: EdgeInsets.only(top: 10.0),
        itemBuilder: (context, index) =>
            _buildListItem(context, track.timeslots[index]),
      ),
    );
  }

  _buildListItem(BuildContext context, schedule) {
    return TimeslotTile(schedule, bloc);
  }
}

class TimeslotTile extends StatelessWidget {
  TimeslotTile(this.timeslot, this.bloc);

  final MainBloc bloc;
  final Timeslot timeslot;
/*

  Elements that can be generated:

  TitleWidget(activity)
  Show activity title;
  Argument must not be null;

  DescriptionWidget(activity)
  Show activity description. Returns an empty container if description is null;


  StartTimeWidget(activity)
  Show activity's start time.
  Argument must not be null;

  SpeakerChipWidget(activity)
  Show a chip with Speaker's avatar and name.
  Returns an empty container if activity doesn't have a speaker (generic activity);

  ActivityChipWidget(activity)
  Show a chip with Activity type (Talk|Workshop)
  Returns an empty container in case of generic activity;

*/

  @override
  Widget build(BuildContext context) {
    final List<Session> sessions = bloc.sessions
        .where((session) => timeslot.sessions.contains(session.id))
        .toList();
    return InkWell(
      onTap: () => _openSessionPage(
          //TODO: Change to process all of sessions, not first only
          context,
          timeslot,
          sessions.first,
          bloc.speakers
              .where((speaker) => sessions.first.speakers.contains(speaker.id))
              .toList()),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                StartTimeWidget(timeslot, sessions),
                ActivityChipWidget(timeslot, sessions),
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TitleWidget(timeslot, sessions),
                    DescriptionWidget(timeslot, sessions),
                    SpeakerChipWidget(timeslot, sessions, bloc),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openSessionPage(BuildContext context, Timeslot timeslot, Session session,
      List<Speaker> speakers) {
    Navigator.push(context,
        SlideRightRoute(widget: SessionView(timeslot, session, speakers)));
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        });
}

//  builder: (context) => SessionView(timeslot, session)));
class SpeakerChipWidget extends GenericScheduleWidget {
  final MainBloc bloc;
  SpeakerChipWidget(Timeslot timeslot, List<Session> sessions, this.bloc)
      : super(timeslot, sessions);

  @override
  Widget build(BuildContext context) {
    if (sessions[0].complexity != null) {
      final List<Speaker> speakers = bloc.speakers
          .where((speaker) => sessions[0].speakers.contains(speaker.id))
          .toList();
      if (speakers.length > 0) {
        return Column(
            children: speakers
                .map((speaker) => Chip(
                      backgroundColor: Colors.white,
                      label: Text(speaker.name),
                      avatar: Hero(
                          tag: "anim_speaker_avatar_${speaker.name}",
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(speaker.photoUrl))),
                    ))
                .toList());
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}

class TitleWidget extends GenericScheduleWidget {
  TitleWidget(Timeslot timeslot, List<Session> sessions)
      : super(timeslot, sessions);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "anim_activity_${timeslot.starttime}",
      child: Material(
          color: Colors.transparent,
          child: Text(
            sessions[0].title,
            textScaleFactor: 1.4,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
    ;
  }
}

class DescriptionWidget extends GenericScheduleWidget {
  DescriptionWidget(Timeslot timeslot, List<Session> sessions)
      : super(timeslot, sessions);

  @override
  Widget build(BuildContext context) {
    return ((sessions[0] != null)
        ? Text(
            sessions[0].description,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          )
        : Container());
  }
}

class StartTimeWidget extends GenericScheduleWidget {
  StartTimeWidget(Timeslot timeslot, List<Session> sessions)
      : super(timeslot, sessions);

  @override
  Widget build(BuildContext context) {
    var color = Utils.hexToColor("#676767");

    if (sessions.first.speakers.isNotEmpty) {
      color = Colors.blueAccent;
    } else {
      color = Colors.deepOrangeAccent;
    }
    return Text(timeslot.starttime,
        textScaleFactor: 1.8,
        style: TextStyle(color: color, fontWeight: FontWeight.w300));
  }
}

class ActivityChipWidget extends GenericScheduleWidget {
  ActivityChipWidget(Timeslot timeslot, List<Session> sessions)
      : super(timeslot, sessions);

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}

abstract class GenericScheduleWidget extends StatelessWidget {
  final Timeslot timeslot;
  final List<Session> sessions;
  GenericScheduleWidget(this.timeslot, this.sessions);
}
