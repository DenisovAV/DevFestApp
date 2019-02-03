import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/resources/ticket_repository.dart';
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

  group('FirestoreTicketsRepository', () {
    test('should listen for updates to the collection', () {
      final ticket = Ticket(
          price: 100,
          name: 'name',
          currency: '\$',
          available: true,
          soldOut: false);
      final snapshot = MockQuerySnapshot();
      final snapshots = Stream.fromIterable([snapshot]);
      final document = MockDocumentSnapshot(ticket.toJson());
      final repository = FirestoreTicketRepository(firestore);

      when(firestore.collection(FirestoreTicketRepository.collection))
          .thenReturn(collection);
      when(collection.snapshots()).thenAnswer((_) => snapshots);
      when(snapshot.documents).thenReturn([document]);

      expect(repository.getTickets(), emits([ticket]));
    });
  });
}

