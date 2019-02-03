import 'package:equatable/equatable.dart';

abstract class SpeakersState extends Equatable {
  SpeakersState([List props = const []]) : super(props);
}

class SpeakersInit extends SpeakersState {
  @override
  String toString() => 'SpeakersInit';
}

class SpeakersLoading extends SpeakersState {
  @override
  String toString() => 'SpeakersLoading';
}

class SpeakersDone extends SpeakersState {
  @override
  String toString() => 'SpeakersDone';
}


