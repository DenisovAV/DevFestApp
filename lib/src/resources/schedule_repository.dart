import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/src/models/schedule.dart';
import 'package:devfest_flutter_app/src/models/session.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';

class FirestoreScheduleRepository extends ScheduleRepository {
  static const String SESSION_COLLECTION = 'sessions';
  static const String SCHEDULE_COLLECTION= 'schedule';
  static const String SPEAKERS_COLLECTION= 'speakers';

  final Firestore firestore;

  FirestoreScheduleRepository(this.firestore);

  Stream<List<Speaker>> getSpeakers() => firestore
      .collection(SPEAKERS_COLLECTION)
      .snapshots()
      .map((snapshot) => snapshot.documents
      .map((doc) => Speaker.fromMap(doc.data, doc.documentID))
      .toList());

  Stream<Schedule> getSchedule(String day) => Firestore.instance
        .collection(SCHEDULE_COLLECTION)
        .document(day)
        .snapshots()
        .map((snapshot) => Schedule.fromMap(snapshot.data));

  Stream<List<Session>> getSessions() => firestore
      .collection(SESSION_COLLECTION)
      .snapshots()
      .map((snapshot) => snapshot.documents
      .map((doc) => Session.fromMap(doc.data, doc.documentID))
      .toList());

  Stream<List<Schedule>> getSchedules() => firestore
      .collection(SCHEDULE_COLLECTION)
      .snapshots()
      .map((snapshot) => snapshot.documents
      .map((doc) => Schedule.fromMap(doc.data))
      .toList());

  Stream<Session> getSessionById(String id) => firestore
      .collection(SESSION_COLLECTION)
      .document(id)
      .snapshots()
      .map((snapshot) => Session.fromMap(snapshot.data, snapshot.documentID));

  Stream<List<Session>> getSessionsByIds(List<String> idList) => firestore
      .collection(SESSION_COLLECTION)
      .snapshots()
      .map((snapshot) => snapshot.documents
          .where((snapshot) => idList.contains(snapshot.documentID))
          .map((doc) => Session.fromMap(doc.data, doc.documentID))
          .toList());
}
