import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String photoUrl;

  User({this.id, this.name, String photoUrl})
      : assert(id != null), this.photoUrl = photoUrl??"",
        super([id, name, photoUrl]);  // Постоянно и в разных местах падает от того что url фото == null. Это скорее затычка.

  @override
  String toString() => 'User{id: $id, name: $name}';
}
