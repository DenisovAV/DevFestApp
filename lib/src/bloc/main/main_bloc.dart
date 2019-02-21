import 'dart:async';

import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/models/session.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/models/team.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';

typedef Future<void> LogoutCall();

class MainBloc {
  final Repository repository;
  LogoutCall logoutCall;
  List<Team> teams = List<Team>();
  List<Speaker> speakers = List<Speaker>();
  List<Schedule> schedules = List<Schedule>();
  List<Ticket> tickets = List<Ticket>();
  List<Session> sessions = List<Session>();

  bool get _isSessionsLoaded => sessions!=null && sessions.isNotEmpty;
  bool get _isScheduleLoaded => schedules!=null && schedules.isNotEmpty;
  bool get _isSpeakerLoaded => speakers!=null && speakers.isNotEmpty;
  bool get _isTeamLoaded => teams!=null && teams.isNotEmpty;
  bool get _isTicketsLoaded => tickets!=null && tickets.isNotEmpty;

  StreamController<BlocEvent> repositoryController = StreamController<BlocEvent>.broadcast();
  StreamController<BlocEvent> eventsController = StreamController<BlocEvent>.broadcast();

  Stream<BlocEvent> get teamsStream => repositoryController.stream.where((event)=> event is TeamLoadedEvent);
  Stream<BlocEvent> get speakersStream => repositoryController.stream.where((event)=> event is SpeakersLoadedEvent);
  Stream<BlocEvent> get ticketsStream => repositoryController.stream.where((event)=> event is TicketsLoadedEvent);
  Stream<BlocEvent> get schedulesStream => repositoryController.stream.where((event)=> event is SchedulesLoadedEvent);
  Stream<BlocEvent> get navigationStream => eventsController.stream.where((event)=> event is NavigatorEvent);
  Stream<BlocEvent> get authStream => eventsController.stream.where((event)=> event is LogoutEvent);
  Sink<BlocEvent> get events => eventsController.sink;

  MainBloc(this.repository, {this.logoutCall}) : assert(repository != null) {
    repository.getTickets().listen(_onTicketsLoaded);
    repository.getTeams().listen(_onTeamsLoaded);
    repository.getSchedules().listen(_onSchedulesLoaded);
    repository.getSessions().listen(_onSessionsLoaded);
    repository.getSpeakers().listen(_onSpeakersLoaded);
   // init();
  }

  bool isRepoLoaded(BlocEvent event){
    event.runtimeType;
    switch (event.runtimeType) {
      case SchedulesLoadedEvent:
        return _isSessionsLoaded && _isSpeakerLoaded && _isScheduleLoaded;
      case TicketsLoadedEvent:
        return _isTicketsLoaded;
      case SpeakersLoadedEvent:
        return _isSpeakerLoaded;
      case TeamLoadedEvent:
        return _isTeamLoaded;
      default: // Without this, you see a WARNING.
        return false; // 'Color.blue'
    }
  }


  checkRepo(BlocEvent event) {
    if (isRepoLoaded(event)) {
      repositoryController.sink.add(event);
    }
  }

  initNavigation() {
    events.add(NavigatorEvent(0));
  }



  _onTeamsLoaded(List<Team> teams) {
    this.teams = teams;
    this.teams
        .forEach((team) => repository.getMembers(team.id).listen((members) {
              team.members = members;
              repositoryController.sink.add(TeamLoadedEvent());
            }));
  }

  _onSpeakersLoaded(List<Speaker> speakers) {
    this.speakers = speakers;
    repositoryController.sink.add(SpeakersLoadedEvent());
    if(_isSessionsLoaded && _isSpeakerLoaded) {
      repositoryController.sink.add(SchedulesLoadedEvent());
    }
  }

  _onSessionsLoaded(List<Session> sessions) {
    this.sessions=sessions;
    if(_isSpeakerLoaded && _isScheduleLoaded) {
      repositoryController.sink.add(SchedulesLoadedEvent());
    }
  }

  _onSchedulesLoaded(List<Schedule> schedules) {
    this.schedules=schedules;
    if(_isSpeakerLoaded && _isSessionsLoaded) {
      repositoryController.sink.add(SchedulesLoadedEvent());
    }
  }

  _onTicketsLoaded(List<Ticket> tickets) {
    this.tickets = tickets;
    repositoryController.sink.add(TicketsLoadedEvent());
  }


  void dispose() {
    repositoryController?.close();
    eventsController?.close();
  }

  void logout(){
    logoutCall();
  }
}
