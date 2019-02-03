import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class HomePageEvent extends Equatable {
  HomePageEvent([List props = const []]) : super(props);
}

class HomePageInitiation extends HomePageEvent {
  @override
  String toString() => 'HomePageInitiation';
}

class HomePageLoaded extends HomePageEvent {
  @override
  String toString() => 'HomePageLoaded';
}

class HighlightsTapped extends HomePageEvent {
  @override
  String toString() => 'HilightsTapped';
}

class TicketTapped extends HomePageEvent {

  final Ticket ticket;

  TicketTapped({@required this.ticket}) : super([ticket]);

  @override
  String toString() => 'TicketTapped { ticket: $ticket }';
}
