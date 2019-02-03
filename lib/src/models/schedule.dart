import 'package:devfest_flutter_app/src/models/track.dart';
import 'package:equatable/equatable.dart';

export 'package:devfest_flutter_app/src/models/timeslot.dart';
export 'package:devfest_flutter_app/src/models/track.dart';

class Schedule extends Equatable {
  static const String DATE = 'date';
  static const String DATE_READABLE = 'dateReadable';
  static const String TRACKS = 'tracks';
  static const String TIMESLOTS = 'timeslots';

  Schedule({
    this.date,
    this.dateReadable,
    this.tracks,
  }) : super([date, dateReadable, tracks]);

  final String date;
  final String dateReadable;
  final List<Track> tracks;

  Schedule.fromMap(Map<String, dynamic> data)
      : this(
            date: data[DATE],
            dateReadable: data[DATE_READABLE],
            tracks: Track.getTracks(data[TRACKS], data[TIMESLOTS]));

  @override
  String toString() => 'Schedule {date: $date}';

  //TODO: Check toJson and fix
  Map<String, Object> toJson() =>
      {DATE: date, DATE_READABLE: dateReadable, TRACKS: tracks};
}
