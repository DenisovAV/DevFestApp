
import 'package:equatable/equatable.dart';

class BlocEvent extends Equatable {

  BlocEvent([List props = const []]) : super(props);

}

class TeamLoadedEvent extends BlocEvent {

  @override
  String toString() => 'TeamLoadedEvent';

}

class TicketsLoadedEvent extends BlocEvent {

  @override
  String toString() => 'TicketsLoadedEvent';

}

class SpeakersLoadedEvent extends BlocEvent {

  @override
  String toString() => 'SpeakersLoadedEvent';

}

class SchedulesLoadedEvent extends BlocEvent {

  @override
  String toString() => 'SchedulesLoadedEvent';

}