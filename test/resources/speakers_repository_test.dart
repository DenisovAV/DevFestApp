import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/resources/speaker_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../consts.dart';
import 'firestore_mocks.dart';

main() {
  MockFirestore firestore;
  MockCollectionReference collection;

  setUp(() {
    firestore = MockFirestore();
    collection = MockCollectionReference();
  });

  group('FirestoreSpeakerRepository', () {
    test('should update speaker on firestore', () {
      final document = MockDocumentReference();
      final repository = FirestoreSpeakerRepository(firestore);

      when(firestore.collection(FirestoreSpeakerRepository.SPEAKERS_COLLECTION))
          .thenReturn(collection);
      when(collection.document(testSpeaker.id)).thenReturn(document);

      repository.updateSpeaker(testSpeaker);

      verify(document.updateData(testSpeaker.toJson()));
    });

    test('should listen for updates to the collection', () {
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(testSpeaker.toJson());
      final repository = FirestoreSpeakerRepository(firestore);

      when(firestore.collection(FirestoreSpeakerRepository.SPEAKERS_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(snapshot.documents).thenReturn([document]);
      when(document.documentID).thenReturn(testSpeaker.id);

      expect(repository.getSpeakers(), emits([testSpeaker]));
    });

    test('should get speakers by id', () {
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(testSpeaker.toJson());
      final documentRef = MockDocumentReference();
      final documentSnapshots = Stream.fromIterable([document]);
      final repository = FirestoreSpeakerRepository(firestore);

      when(firestore.collection(FirestoreSpeakerRepository.SPEAKERS_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(documentRef.snapshots()).thenAnswer((_) => documentSnapshots);
      when(collection.document(testSpeaker.id)).thenAnswer((_) => documentRef);
      when(snapshot.documents).thenReturn([document]);
      when(document.documentID).thenReturn(testSpeaker.id);

      expect(repository.getSpeakerById(testSpeaker.id), emits(testSpeaker));
      expect(repository.getSpeakersByIds([testSpeaker.id]), emits([testSpeaker]));
    });
  });
}
