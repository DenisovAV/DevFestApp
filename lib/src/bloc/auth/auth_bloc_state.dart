import 'package:devfest_flutter_app/src/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

class AuthInit extends AuthState {
  @override
  String toString() => 'AuthInit';
}

class AuthLoggedIn extends AuthState {
  final User user;

  AuthLoggedIn({
    @required this.user,
  }) : super([user]);

  @override
  String toString() => 'AuthLoggedIn {user: $user}';
}

class AuthLoggedOut extends AuthState {
  @override
  String toString() => 'AuthLoggedOut';
}

