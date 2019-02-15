import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/models/session.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/models/team.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';

class FirestoreRepository extends Repository {

  static const String SESSION_COLLECTION = 'sessions';
  static const String SCHEDULE_COLLECTION = 'schedule';
  static const String SPEAKERS_COLLECTION = 'speakers';
  static const String TEAM_COLLECTION = 'team';
  static const String MEMBERS_COLLECTION = 'members';
  static const String TICKETS_COLLECTION = 'tickets';

  final Firestore firestore;

  FirestoreRepository(this.firestore);

  Stream<List<Speaker>> getSpeakers() =>
      firestore
          .collection(SPEAKERS_COLLECTION)
          .snapshots()
          .map((snapshot) =>
          snapshot.documents
              .map((doc) => Speaker.fromMap(doc.data, doc.documentID))
              .toList());

  Stream<Schedule> getSchedule(String day) =>
      Firestore.instance
          .collection(SCHEDULE_COLLECTION)
          .document(day)
          .snapshots()
          .map((snapshot) => Schedule.fromMap(snapshot.data));

  Stream<List<Session>> getSessions() =>
      firestore
          .collection(SESSION_COLLECTION)
          .snapshots()
          .map((snapshot) =>
          snapshot.documents
              .map((doc) => Session.fromMap(doc.data, doc.documentID))
              .toList());

  Stream<List<Schedule>> getSchedules() =>
      firestore
          .collection(SCHEDULE_COLLECTION)
          .snapshots()
          .map((snapshot) =>
          snapshot.documents
              .map((doc) => Schedule.fromMap(doc.data))
              .toList());

  Stream<Session> getSessionById(String id) =>
      firestore
          .collection(SESSION_COLLECTION)
          .document(id)
          .snapshots()
          .map((snapshot) =>
          Session.fromMap(snapshot.data, snapshot.documentID));

  Stream<List<Session>> getSessionsByIds(List<String> idList) =>
      firestore
          .collection(SESSION_COLLECTION)
          .snapshots()
          .map((snapshot) =>
          snapshot.documents
              .where((snapshot) => idList.contains(snapshot.documentID))
              .map((doc) => Session.fromMap(doc.data, doc.documentID))
              .toList());

  Stream<Speaker> getSpeakerById(String id) => firestore
      .collection(SPEAKERS_COLLECTION)
      .document(id)
      .snapshots()
      .map((snapshot) => Speaker.fromMap(snapshot.data, snapshot.documentID));

  Stream<List<Speaker>> getSpeakersByIds(List<String> idList) => firestore
      .collection(SPEAKERS_COLLECTION)
      .snapshots()
      .map((snapshot) => snapshot.documents
      .where((snapshot) => idList.contains(snapshot.documentID))
      .map((doc) => Speaker.fromMap(doc.data, doc.documentID))
      .toList());

  Future<void> updateSpeaker(Speaker speaker) => firestore
      .collection(SPEAKERS_COLLECTION)
      .document(speaker.id)
      .updateData(speaker.toJson());

  Stream<List<Team>> getTeams() =>
      firestore
          .collection(TEAM_COLLECTION)
          .snapshots()
          .map((snapshot) =>
          snapshot.documents
              .map((doc) => Team.fromMap(doc.data, doc.documentID))
              .toList());

  Stream<List<Member>> getMembers(String team) {
    return firestore.collection(TEAM_COLLECTION)
        .document(team)
        .collection(MEMBERS_COLLECTION)
        .snapshots()
        .map((snapshot) =>
        snapshot.documents
            .map((doc) => Member.fromMap(doc.data))
            .toList());
  }

  Stream<List<Ticket>> getTickets() =>
      firestore
          .collection(TICKETS_COLLECTION)
          .snapshots()
          .map((snapshot) => snapshot.documents
          .map((doc) => Ticket.fromMap(doc.data))
          .toList());
}