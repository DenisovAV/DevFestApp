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
      when(collection.document(TEST_SPEAKER.id)).thenReturn(document);

      repository.updateSpeaker(TEST_SPEAKER);

      verify(document.updateData(TEST_SPEAKER.toJson()));
    });

    test('should listen for updates to the collection', () {
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(TEST_SPEAKER.toJson());
      final repository = FirestoreSpeakerRepository(firestore);

      when(firestore.collection(FirestoreSpeakerRepository.SPEAKERS_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(snapshot.documents).thenReturn([document]);
      when(document.documentID).thenReturn(TEST_SPEAKER.id);

      expect(repository.getSpeakers(), emits([TEST_SPEAKER]));
    });

    test('should get speakers by id', () {
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(TEST_SPEAKER.toJson());
      final documentRef = MockDocumentReference();
      final documentSnapshots = Stream.fromIterable([document]);
      final repository = FirestoreSpeakerRepository(firestore);

      when(firestore.collection(FirestoreSpeakerRepository.SPEAKERS_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(documentRef.snapshots()).thenAnswer((_) => documentSnapshots);
      when(collection.document(TEST_SPEAKER.id)).thenAnswer((_) => documentRef);
      when(snapshot.documents).thenReturn([document]);
      when(document.documentID).thenReturn(TEST_SPEAKER.id);

      expect(repository.getSpeakerById(TEST_SPEAKER.id), emits(TEST_SPEAKER));
      expect(repository.getSpeakersByIds([TEST_SPEAKER.id]), emits([TEST_SPEAKER]));
    });
  });
}
