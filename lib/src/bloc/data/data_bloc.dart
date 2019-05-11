import 'dart:async';

import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/models/partner.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/models/session.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/models/team.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:url_launcher/url_launcher.dart';



class DataBloc {
  final Repository _repository;
  List<Team> teams = List<Team>();
  List<Partner> partners = List();
  List<Speaker> speakers = List<Speaker>();
  List<Schedule> schedules = List<Schedule>();
  List<Ticket> tickets = List<Ticket>();
  List<Session> sessions = List<Session>();

  bool get _isSessionsLoaded => sessions!=null && sessions.isNotEmpty;
  bool get _isScheduleLoaded => schedules!=null && schedules.isNotEmpty;
  bool get _isSpeakerLoaded => speakers!=null && speakers.isNotEmpty;
  bool get _isTeamLoaded => teams!=null && teams.isNotEmpty;
  bool get _isPartnersLoaded => partners!=null && partners.isNotEmpty;
  bool get _isTicketsLoaded => tickets!=null && tickets.isNotEmpty;

  StreamController<BlocEvent> _repositoryController = StreamController.broadcast();
  StreamController<BlocEvent> _eventsController = StreamController.broadcast();

  Stream<BlocEvent> get partnersStream => _repositoryController.stream.where((event)=> event is PartnersLoadedEvent);
  Stream<BlocEvent> get teamsStream => _repositoryController.stream.where((event)=> event is TeamLoadedEvent);
  Stream<BlocEvent> get speakersStream => _repositoryController.stream.where((event)=> event is SpeakersLoadedEvent);
  Stream<BlocEvent> get ticketsStream => _repositoryController.stream.where((event)=> event is TicketsLoadedEvent);
  Stream<BlocEvent> get schedulesStream => _repositoryController.stream.where((event)=> event is SchedulesLoadedEvent);
  Stream<BlocEvent> get navigationStream => _eventsController.stream.where((event)=> event is NavigatorEvent);
  Sink<BlocEvent> get events => _eventsController.sink;

  DataBloc(repository) : _repository = repository, assert(repository != null) {
    repository.getTickets().listen(_onTicketsLoaded);
    repository.getTeams().listen(_onTeamsLoaded);
    repository.getSchedules().listen(_onSchedulesLoaded);
    repository.getSessions().listen(_onSessionsLoaded);
    repository.getSpeakers().listen(_onSpeakersLoaded);
    repository.getPartners().listen(_onPartnersLoaded);
    _eventsController.stream.listen(_onEvent);
  }

  bool isRepoLoaded(BlocEvent event){
    switch (event.runtimeType) {
      case SchedulesLoadedEvent:
        return _isSessionsLoaded && _isSpeakerLoaded && _isScheduleLoaded;
      case TicketsLoadedEvent:
        return _isTicketsLoaded;
      case SpeakersLoadedEvent:
        return _isSpeakerLoaded;
      case TeamLoadedEvent:
        return _isTeamLoaded;
      case PartnersLoadedEvent:
        return _isPartnersLoaded;
      default:
        return false;
    }
  }


  checkRepo(BlocEvent event) {
    print(speakers.length);
    if (isRepoLoaded(event)) {
      _repositoryController.sink.add(event);
    }
  }

  initNavigation() {
    events.add(NavigatorEvent(0));
  }

  _onTeamsLoaded(List<Team> teams) {
    this.teams = teams;
    this.teams
        .forEach((team) => _repository.getMembers(team.id).listen((members) {
              team.members = members;
              _repositoryController.sink.add(TeamLoadedEvent());
            }));
  }

  _onPartnersLoaded(List<Partner> partners) {
    this.partners = partners;
    this.partners
        .forEach((partner) => _repository.getLogos(partner.id).listen((logos) {
      partner.logos= logos;
      _repositoryController.sink.add(PartnersLoadedEvent());
    }));
  }

  _onSpeakersLoaded(List<Speaker> speakers) {
    this.speakers = speakers;
    _repositoryController.sink.add(SpeakersLoadedEvent());
    if(_isSessionsLoaded && _isSpeakerLoaded) {
      _repositoryController.sink.add(SchedulesLoadedEvent());
    }
  }

  _onSessionsLoaded(List<Session> sessions) {
    this.sessions=sessions;
    if(_isSpeakerLoaded && _isScheduleLoaded) {
      _repositoryController.sink.add(SchedulesLoadedEvent());
    }
  }

  _onSchedulesLoaded(List<Schedule> schedules) {
    this.schedules=schedules;
    if(_isSpeakerLoaded && _isSessionsLoaded) {
      _repositoryController.sink.add(SchedulesLoadedEvent());
    }
  }

  _onTicketsLoaded(List<Ticket> tickets) {
    this.tickets = tickets;
    _repositoryController.sink.add(TicketsLoadedEvent());
  }

  _onEvent(BlocEvent event) {
    switch (event.runtimeType){
      case TicketTappedEvent:
        _launchURL((event as TicketTappedEvent).ticket.url);
        break;
      case PartnerLogoTappedEvent:
        _launchURL((event as PartnerLogoTappedEvent).logo.linkUrl);
        break;
      case BadgeTappedEvent:
        _launchURL((event as BadgeTappedEvent).badge.link);
        break;
    }
  }

  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }


  void dispose() {
    _repositoryController?.close();
    _eventsController?.close();
  }

}
