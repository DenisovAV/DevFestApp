import 'package:devfest_flutter_app/src/models/partner.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/models/session.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/models/team.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/models/user.dart';

enum AuthType { google, anonymous }

abstract class UserRepository {
  Future<User> login(AuthType authType);
  Future<void> logout();
  Stream<User> getAuthorizedUser();
}

abstract class Repository {
  Stream<List<Partner>> getPartners();
  Stream<List<Logo>> getLogos(String partner);
  Stream<List<Team>> getTeams();
  Stream<List<Member>> getMembers(String team);
  Stream<List<Ticket>> getTickets();
  Stream<Session> getSessionById(String name);
  Stream<List<Session>> getSessions();
  Stream<List<Session>> getSessionsByIds(List<String> listNames);
  Stream<Schedule> getSchedule(String day);
  Stream<List<Schedule>> getSchedules();
  Stream<List<Speaker>> getSpeakers();
  Stream<Speaker> getSpeakerById(String name);
  Stream<List<Speaker>> getSpeakersByIds(List<String> listNames);
  Future<void> updateSpeaker(Speaker speaker);
}