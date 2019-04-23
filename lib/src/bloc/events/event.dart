
import 'package:devfest_flutter_app/src/models/partner.dart';
import 'package:devfest_flutter_app/src/models/social.dart';
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


class PartnersLoadedEvent extends BlocEvent {

  @override
  String toString() => 'PartnersLoadedEvent';

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

class PartnerLogoTappedEvent extends BlocEvent {

  final Logo logo;

  PartnerLogoTappedEvent(this.logo);

  @override
  String toString() => 'ParnterLogoTappedEvent {logo: $logo}';

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

class BadgeTappedEvent extends BlocEvent {

  final Badge badge;

  BadgeTappedEvent(this.badge);

  @override
  String toString() => 'BadgeTappedEvent {badge: $badge}';

}

class SocialTappedEvent extends BlocEvent {

  final Social social;

  SocialTappedEvent(this.social);

  @override
  String toString() => 'SocialTappedEvent {social: $social}';

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

class SignInGoogleEvent extends BlocEvent {

  @override
  String toString() => 'SignInGoogleEvent';

}

class SignInAnonimousEvent extends BlocEvent {

  @override
  String toString() => 'SignInAnonimousEvent';

}


class LoggingInEvent extends BlocEvent {

  @override
  String toString() => 'LoggingInEvent';

}

class LoggingOutEvent extends BlocEvent {

  @override
  String toString() => 'LoggingOutEvent';

}