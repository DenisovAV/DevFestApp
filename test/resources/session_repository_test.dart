import 'package:devfest_flutter_app/src/models/session.dart';
import 'package:devfest_flutter_app/src/resources/schedule_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'firestore_mocks.dart';

main() {
  MockFirestore firestore;
  MockCollectionReference collection;

  setUp(() {
    firestore = MockFirestore();
    collection = MockCollectionReference();
  });

  group('FirestoreSessionRepository', () {
    test('should get sessions by id', () {
      final session = Session(
          id: '1',
          title: 'name',
      );
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(session.toJson());
      final documentRef = MockDocumentReference();
      final documentSnapshots = Stream.fromIterable([document]);
      final repository = FirestoreScheduleRepository(firestore);

      when(firestore.collection(FirestoreScheduleRepository.SESSION_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(documentRef.snapshots()).thenAnswer((_) => documentSnapshots);
      when(collection.document(session.id)).thenAnswer((_) => documentRef);
      when(snapshot.documents).thenReturn([document]);
      when(document.documentID).thenReturn(session.id);

      expect(repository.getSessionById(session.id), emits(session));
      expect(repository.getSessionsByIds([session.id]), emits([session]));
    });
  });
}

