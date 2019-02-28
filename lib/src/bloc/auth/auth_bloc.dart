import 'dart:async';

import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc_state.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthState get initialState => AuthInit();

  @override
  Stream<AuthState> mapEventToState(
    AuthState currentState,
    AuthEvent event,
  ) => userRepository.getAuthorizedUser().map(
            (user) => (user != null ? AuthLoggedIn(user: user): AuthLoggedOut()));

}
