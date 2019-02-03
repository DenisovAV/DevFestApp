import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

class MockFirestore extends Mock implements Firestore {}
class MockCollectionReference extends Mock implements CollectionReference {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot {
  final Map<String, dynamic> data;
  MockDocumentSnapshot([this.data]);
  dynamic operator [](String key) => data[key];
}
class MockDocumentReference extends Mock implements DocumentReference {}
class MockQuerySnapshot extends Mock implements QuerySnapshot {}