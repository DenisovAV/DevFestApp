import 'package:equatable/equatable.dart';

class Timeslot extends Equatable {
  static const String END_TIME = 'endTime';
  static const String START_TIME = 'startTime';
  static const String SESSIONS = 'sessions';
  static const String ITEMS = 'items';

  Timeslot({this.endtime, this.starttime, this.sessions})
      : super([endtime, starttime, sessions]);

  final String endtime;
  final String starttime;
  final List<String> sessions;

  static List<Timeslot> getTimeslots(List<dynamic> list, int index) =>
      list?.map((item) => Timeslot.fromMap(item, index))?.toList();

  Timeslot.fromMap(Map<dynamic, dynamic> data, int index)
      : this(
      endtime: data[END_TIME],
      starttime: data[START_TIME],
      sessions: getSessionId(data[SESSIONS], index));

  static List<String> getSessionId(List<dynamic> list, int index) =>
      List<int>.from(list[list.length != 1 ? index : 0][ITEMS])
          .map((f) => f.toString())
          .toList();

  @override
  String toString() =>
      'Timeslot { endtime: $endtime, starttime: $starttime, sessions: $sessions}';

  //TODO: check in tests and fix
  Map<String, Object> toJson() => {
    END_TIME: endtime,
    START_TIME: starttime,
    SESSIONS: [sessions]
  };
}
