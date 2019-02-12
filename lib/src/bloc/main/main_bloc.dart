import 'dart:async';

import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/models/session.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/models/team.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';

class MainBloc {
  final Repository repository;
  List<Team> teams = List<Team>();
  List<Speaker> speakers = List<Speaker>();
  List<Schedule> schedules = List<Schedule>();
  List<Ticket> tickets = List<Ticket>();
  List<Session> sessions = List<Session>();

  bool get isSessionsLoaded => sessions!=null && sessions.isNotEmpty;
  bool get isScheduleLoaded => schedules!=null && schedules.isNotEmpty;
  bool get isSpeakerLoaded => speakers!=null && speakers.isNotEmpty;

  final teamController = StreamController<BlocEvent>();
  final speakerController = StreamController<BlocEvent>();
  final ticketController = StreamController<BlocEvent>();
  final scheduleController = StreamController<BlocEvent>();

  Stream<BlocEvent> get teamsStream => teamController.stream;
  Stream<BlocEvent> get speakersStream => speakerController.stream;
  Stream<BlocEvent> get ticketsStream => ticketController.stream;
  Stream<BlocEvent> get schedulesStream => scheduleController.stream;

  MainBloc(this.repository) : assert(repository != null) {
    init();
  }

  init() {
    repository.getTickets().listen(_onTicketsLoaded);
    repository.getTeams().listen(_onTeamsLoaded);
    repository.getSchedules().listen(_onSchedulesLoaded);
    repository.getSessions().listen(_onSessionsLoaded);
    repository.getSpeakers().listen(_onSpeakersLoaded);
  }

  _onTeamsLoaded(List<Team> teams) {
    this.teams = teams;
    this.teams
        .forEach((team) => repository.getMembers(team.id).listen((members) {
              team.members = members;
              teamController.sink.add(TeamLoadedEvent());
            }));
  }

  _onSpeakersLoaded(List<Speaker> speakers) {
    this.speakers = speakers;
    speakerController.sink.add(SpeakersLoadedEvent());
    if(isSessionsLoaded && isSpeakerLoaded) {
      scheduleController.sink.add(SchedulesLoadedEvent());
    }
  }

  _onSessionsLoaded(List<Session> sessions) {
    if(isSpeakerLoaded && isScheduleLoaded) {
      scheduleController.sink.add(SchedulesLoadedEvent());
    }
  }

  _onSchedulesLoaded(List<Schedule> schedules) {
    if(isSpeakerLoaded && isSessionsLoaded) {
      scheduleController.sink.add(SchedulesLoadedEvent());
    }
  }

  _onTicketsLoaded(List<Ticket> tickets) {
    this.tickets = tickets;
    ticketController.sink.add(TicketsLoadedEvent());
  }


  void dispose() {
    teamController?.close();
    speakerController?.close();
    ticketController?.close();
    scheduleController?.close();
  }
}
