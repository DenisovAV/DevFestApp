
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
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

class HighlightsTappedEvent extends BlocEvent {

  @override
  String toString() => 'HighlightsTappedEvent';

}

class TicketTappedEvent extends BlocEvent {

  final Ticket ticket;

  TicketTappedEvent(this.ticket);

  @override
  String toString() => 'TicketTappedEvent {ticket: $ticket}';

}


class SpeakersLoadedEvent extends BlocEvent {

  @override
  String toString() => 'SpeakersLoadedEvent';

}

class SpeakersTappedEvent extends BlocEvent {

  final Speaker speaker;

  SpeakersTappedEvent(this.speaker);

  @override
  String toString() => 'SpeakerTappedEvent {speaker: $speaker}';

}

class SchedulesLoadedEvent extends BlocEvent {

  @override
  String toString() => 'SchedulesLoadedEvent';

}

class NavigatorEvent extends BlocEvent {

  int index;

  NavigatorEvent(this.index);

  @override
  String toString() => 'NavigatorEvent index: $index';

}

class LogoutEvent extends BlocEvent {

  @override
  String toString() => 'LogoutEvent';

}