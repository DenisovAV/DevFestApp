import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/src/models/team.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';

class FirestoreTeamRepository extends TeamRepository {
  static String TEAM_COLLECTION = 'team';
  static String MEMBERS_COLLECTION = 'members';

  final Firestore firestore;

  FirestoreTeamRepository(this.firestore);

  Stream<List<Team>> getTeams() =>
      firestore
          .collection(TEAM_COLLECTION)
          .snapshots()
          .map((snapshot) =>
          snapshot.documents
              .map((doc) => Team.fromMap(doc.data, doc.documentID))
              .toList());

  Stream<List<Member>> getMembers(String team) =>
      firestore
          .collection(TEAM_COLLECTION)
          .document(team)
          .collection(MEMBERS_COLLECTION)
          .snapshots()
          .map((snapshot) =>
          snapshot.documents
              .map((doc) => Member.fromMap(doc.data))
              .toList());
}