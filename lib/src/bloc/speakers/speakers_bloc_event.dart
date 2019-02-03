import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class SpeakersEvent extends Equatable {
  SpeakersEvent([List props = const []]) : super(props);
}

class SpeakersGridInitiation extends SpeakersEvent {
  @override
  String toString() => 'SpeakersGridOpened';
}

class SpeakersLoaded extends SpeakersEvent {
  @override
  String toString() => 'SpeakersLoaded';
}

class SpeakerFooterTapped extends SpeakersEvent {
  final Speaker speaker;

  SpeakerFooterTapped({@required this.speaker}) : super([speaker]);

  @override
  String toString() => 'SpeakerTapped { speaker: $speaker }';
}
