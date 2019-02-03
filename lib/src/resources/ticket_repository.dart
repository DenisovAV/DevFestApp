import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/src/models/ticket.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';

class FirestoreTicketRepository extends TicketRepository {
  static String collection = 'tickets';

  final Firestore firestore;

  FirestoreTicketRepository(this.firestore);

  Stream<List<Ticket>> getTickets() =>
      firestore
          .collection(collection)
          .snapshots()
          .map((snapshot) => snapshot.documents
              .map((doc) => Ticket.fromMap(doc.data))
              .toList());
}
