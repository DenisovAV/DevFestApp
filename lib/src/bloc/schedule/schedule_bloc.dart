import 'dart:async';

import 'package:devfest_flutter_app/src/bloc/schedule/schedule_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/schedule/schedule_bloc_state.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/models/session.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;
  List<Schedule> _schedule = List<Schedule>();
  List<Session> _sessions = List<Session>();
  List<Speaker> _speakers = List<Speaker>();

  ScheduleBloc({@required this.scheduleRepository})
      : assert(scheduleRepository != null);

  bool get isSessionsLoaded => _sessions!=null && !_sessions.isEmpty;
  bool get isScheduleLoaded => _schedule!=null && !_schedule.isEmpty;
  bool get isSpeakerLoaded => _speakers!=null && !_speakers.isEmpty;

  List<Schedule> get schedule => _schedule;
  List<Session> get sessions => _sessions;
  List<Speaker> get speakers => _speakers;

  init() {
    scheduleRepository.getSchedules().listen((schedule) {
      this._schedule = schedule;
      this.dispatch(ScheduleLoaded());
    });

    scheduleRepository.getSessions().listen((sessions) {
      this._sessions = sessions;
      this.dispatch(SessionsLoaded());
    });

    scheduleRepository.getSpeakers().listen((speakers) {
      this._speakers = speakers;
      this.dispatch(SpeakersLoaded());
    });
  }


  @override
  ScheduleState get initialState => ScheduleInit();

  @override
  Stream<ScheduleState> mapEventToState(ScheduleState currentState,
      ScheduleEvent event,) async* {
    if(event is ScheduleInitiation) {
      init();
    }
    if(event is ScheduleLoaded) {
      yield ScheduleLoading();
      if(isSessionsLoaded && isSpeakerLoaded) {
        yield ScheduleDone();
      }
    }
    if(event is SessionsLoaded) {
      ScheduleLoading();
      if(isScheduleLoaded && isSpeakerLoaded) {
        yield ScheduleDone();
      }
    }
    if(event is SpeakersLoaded) {
      yield ScheduleLoading();
      if(isScheduleLoaded && isSessionsLoaded) {
        yield ScheduleDone();
      }
    }
  }
}
