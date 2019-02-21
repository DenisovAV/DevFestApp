import 'package:devfest_flutter_app/src/resources/repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../consts.dart';
import 'firestore_mocks.dart';

main() {
  MockFirestore firestore;


  setUp(() {
    firestore = MockFirestore();
  });

  group('Sessions', () {
    test('should get sessions by id', () {
      final collection = MockCollectionReference();
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(testSession.toJson());
      final documentRef = MockDocumentReference();
      final documentSnapshots = Stream.fromIterable([document]);
      final repository = FirestoreRepository(firestore);


      when(firestore.collection(FirestoreRepository.SESSION_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(documentRef.snapshots()).thenAnswer((_) => documentSnapshots);
      when(collection.document(testSession.id)).thenAnswer((_) => documentRef);
      when(snapshot.documents).thenReturn([document]);
      when(document.documentID).thenReturn(testSession.id);

      expect(repository.getSessionById(testSession.id), emits(testSession));
      expect(repository.getSessionsByIds([testSession.id]), emits([testSession]));
    });

    test('should listen for updates to the collection', () {
      final collection = MockCollectionReference();
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(testSession.toJson());
      final repository = FirestoreRepository(firestore);

      when(firestore.collection(FirestoreRepository.SESSION_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(snapshot.documents).thenReturn([document]);
      when(document.documentID).thenReturn(testSession.id);

      expect(repository.getSessions(), emits([testSession]));
    });
  });

  group('Speakers', () {
    test('should update speaker on firestore', () {
      final collection = MockCollectionReference();
      final document = MockDocumentReference();
      final repository = FirestoreRepository(firestore);

      when(firestore.collection(FirestoreRepository.SPEAKERS_COLLECTION))
          .thenReturn(collection);
      when(collection.document(testSpeaker.id)).thenReturn(document);
      repository.updateSpeaker(testSpeaker);
      verify(document.updateData(testSpeaker.toJson()));
    });

    test('should listen for updates to the collection', () {
      final collection = MockCollectionReference();
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(testSpeaker.toJson());
      final repository = FirestoreRepository(firestore);

      when(firestore.collection(FirestoreRepository.SPEAKERS_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(snapshot.documents).thenReturn([document]);
      when(document.documentID).thenReturn(testSpeaker.id);

      expect(repository.getSpeakers(), emits([testSpeaker]));
    });

    test('should get speakers by id', () {
      final collection = MockCollectionReference();
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(testSpeaker.toJson());
      final documentRef = MockDocumentReference();
      final documentSnapshots = Stream.fromIterable([document]);
      final repository = FirestoreRepository(firestore);

      when(firestore.collection(FirestoreRepository.SPEAKERS_COLLECTION))
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

  group('Tickets', () {
    test('should listen for updates to the collection', () {
      final collection = MockCollectionReference();
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(testTicket.toJson());
      final repository = FirestoreRepository(firestore);

      when(firestore.collection(FirestoreRepository.TICKETS_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(snapshot.documents).thenReturn([document]);

      expect(repository.getTickets(), emits([testTicket]));
    });
  });

  group('Team', () {
    test('should listen for updates to the team collection', () {
      final collection = MockCollectionReference();
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(testTeam.toJson());
      final repository = FirestoreRepository(firestore);

      when(firestore.collection(FirestoreRepository.TEAM_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(snapshot.documents).thenReturn([document]);
      when(document.documentID).thenReturn(testTeam.id);

      expect(repository.getTeams(), emits([testTeam]));
    });

    test('should listen for updates to the team members collection', () {
      final collection = MockCollectionReference();
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(testMember.toJson());
      final repository = FirestoreRepository(firestore);
      final memberCollection = MockCollectionReference();
      final documentRef = MockDocumentReference();

      when(firestore.collection(FirestoreRepository.TEAM_COLLECTION))
          .thenReturn(collection);
      when(collection.document(testTeam.id)).thenAnswer((_) => documentRef);
      when(documentRef.collection(FirestoreRepository.MEMBERS_COLLECTION))
          .thenReturn(memberCollection);
      when(memberCollection.snapshots()).thenAnswer((_) => snapshots);
      when(snapshot.documents).thenReturn([document]);

      expect(repository.getMembers(testTeam.id), emits([testMember]));
    });
  });

  group('Schedule', () {
    test('should listen for updates to the collection', () {
      final collection = MockCollectionReference();
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(testSchedule.toJson());
      final repository = FirestoreRepository(firestore);

      when(firestore.collection(FirestoreRepository.SCHEDULE_COLLECTION))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(snapshot.documents).thenReturn([document]);

      expect(repository.getSchedule(any), emits([testSchedule]));
    });
  });
}