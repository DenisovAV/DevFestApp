import 'package:equatable/equatable.dart';

abstract class ScheduleState extends Equatable {
  ScheduleState([List props = const []]) : super(props);
}

class ScheduleInit extends ScheduleState {
  @override
  String toString() => 'ScheduleInit';
}

class ScheduleLoading extends ScheduleState {
  @override
  String toString() => 'ScheduleLoading';
}

class ScheduleDone extends ScheduleState {
  @override
  String toString() => 'ScheduleDone';
}


