import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class HomePageState extends Equatable {
  HomePageState([List props = const []]) : super(props);
}

class HomePageInit extends HomePageState {
  @override
  String toString() => 'HomePageInit';
}

class HomePageDone extends HomePageState{
  @override
  String toString() => 'HomePageDone';
}

class TicketChoosen extends HomePageState{
  @override
  String toString() => 'TicketChoosen';
}

class HighlightsChoosen extends HomePageState{
  @override
  String toString() => 'HighLightsChoosen';
}

