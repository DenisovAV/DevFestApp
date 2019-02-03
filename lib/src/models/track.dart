import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/models/timeslot.dart';
import 'package:equatable/equatable.dart';

class Track extends Equatable {
  static const String TITLE = 'title';

  Track({this.title, this.timeslots}) : super([title, timeslots]);

  final String title;
  final List<Timeslot> timeslots;

  Track.fromMap(Map<dynamic, dynamic> data, List<dynamic> list, int index)
      : this(title: data[TITLE], timeslots: Timeslot.getTimeslots(list, index));

  static List<Track> getTracks(
      List<dynamic> listTracks, List<dynamic> listTimeslots) =>
      listTracks
          ?.map((item) =>
          Track.fromMap(item, listTimeslots, listTracks.indexOf(item)))
          ?.toList();

  //TODO: Check toJson and fix
  Map<String, Object> toJson() =>
      {TITLE: title, Schedule.TIMESLOTS: timeslots};
}