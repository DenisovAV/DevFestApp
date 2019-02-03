import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class SignInState extends Equatable {
  SignInState([List props = const []]) : super(props);
}

class SignInInitial extends SignInState {
  @override
  String toString() => 'SignInInitial';
}

class SignInLoading extends SignInState {
  @override
  String toString() => 'SignInLoading';
}

class SignInFailure extends SignInState {
  final String error;

  SignInFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'SignInFailure { error: $error }';
}
