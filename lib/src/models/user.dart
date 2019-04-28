import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String photoUrl;

  User({this.id, this.name, this.photoUrl})
      : assert(id != null),
        super([id, name, photoUrl]);

  @override
  String toString() => 'User{id: $id, name: $name}';
}
