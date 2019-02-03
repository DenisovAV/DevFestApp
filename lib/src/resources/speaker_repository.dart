import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';

class FirestoreSpeakerRepository extends SpeakerRepository {
  static const String SPEAKERS_COLLECTION = 'speakers';

  final Firestore firestore;

  FirestoreSpeakerRepository(this.firestore);

  Stream<List<Speaker>> getSpeakers() => firestore
      .collection(SPEAKERS_COLLECTION)
      .snapshots()
      .map((snapshot) => snapshot.documents
      .map((doc) => Speaker.fromMap(doc.data, doc.documentID))
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
}
