import 'dart:async';

import 'package:devfest_flutter_app/src/bloc/speakers/speakers_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/speakers/speakers_bloc_state.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class SpeakerBloc extends Bloc<SpeakersEvent, SpeakersState> {
  final SpeakerRepository speakerRepository;
  List<Speaker> _speakers = List<Speaker>();

  SpeakerBloc({@required this.speakerRepository})
      : assert(speakerRepository != null);

  init(){
    speakerRepository.getSpeakers().listen((speakers) {
      this._speakers = speakers;
      print('stream get new message');
      try {
        this.dispatch(SpeakersLoaded());
      }
      catch (e) {
        print(e);
        print('errrer');
      };
    });
  }

  List<Speaker> get speakers => _speakers;

  bool get isSpeakersLoaded => _speakers!=null && !_speakers.isEmpty;

  @override
  SpeakersState get initialState => SpeakersInit();

  @override
  Stream<SpeakersState> mapEventToState(SpeakersState currentState,
      SpeakersEvent event,) async* {
    if(event is SpeakersGridInitiation) {
        if(!isSpeakersLoaded) init();
    }
    if (event is SpeakerFooterTapped) {
      print(event.speaker.toString() + ' is tapped');
      print(currentState);
    }
    if(event is SpeakersLoaded) {
      print('yyyyy');
      yield SpeakersLoading();
      print('xxxxxxx');
      yield SpeakersDone();
    }
  }
}
