import 'package:equatable/equatable.dart';

class ScheduleEvent extends Equatable {
  ScheduleEvent([List props = const []]) : super(props);
}

class ScheduleInitiation extends ScheduleEvent {
  @override
  String toString() => 'ScheduleInitiation';
}

class ScheduleLoaded extends ScheduleEvent {
  @override
  String toString() => 'SpeakersLoaded';
}

class SessionsLoaded extends ScheduleEvent {
  @override
  String toString() => 'SessionsLoaded';
}

class SpeakersLoaded extends ScheduleEvent {
  @override
  String toString() => 'SpeakersLoaded';
}
