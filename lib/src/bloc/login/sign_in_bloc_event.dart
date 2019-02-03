import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  AuthType type;
  SignInEvent([List props = const []]) : super(props);
}

class GoogleSignInButtonPressed extends SignInEvent {

  GoogleSignInButtonPressed() {
    type = AuthType.google;
  }

  @override
  String toString() =>
      'GoogleSignInButtonPressed';
}

class AnonymousSignInButtonPressed extends SignInEvent {

  AnonymousSignInButtonPressed(){
    type=AuthType.anonymous;
  }

  @override
  String toString() =>
      'AnonymousSignInButtonPressed';
}
