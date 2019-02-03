import 'dart:async';

import 'package:devfest_flutter_app/src/bloc/login/sign_in_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/login/sign_in_bloc_state.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;

  SignInBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  SignInState get initialState => SignInInitial();

  @override
  Stream<SignInState> mapEventToState(
    SignInState currentState,
    SignInEvent event,
  ) async* {
    yield SignInLoading();
    try {
      await userRepository.login(event.type);
      yield SignInInitial();
    } catch (error) {
      yield SignInFailure(error: error.toString());
    }
  }
}
