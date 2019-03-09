import 'dart:async';

import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/models/user.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';

class AuthBloc {
  final UserRepository _userRepository;
  User user;

  StreamController<BlocEvent> _authController = StreamController();
  StreamController<BlocEvent> _eventsController = StreamController();

  Stream<BlocEvent> get authStream => _authController.stream;
  Stream<BlocEvent> get _eventStream => _eventsController.stream;
  Sink<BlocEvent> get events => _eventsController.sink;

  AuthBloc(userRepository) : _userRepository = userRepository,
        assert(userRepository != null) {
    _userRepository.getAuthorizedUser().listen(_onAuthorized);
    _eventStream.listen(_onEvent);
  }

  _onAuthorized(User user) {
    this.user = user;
    _authController.sink.add(user != null ? LoggingInEvent(): LoggingOutEvent());
  }

  _onEvent(BlocEvent event) {
    if(event==LogoutEvent()){
      _userRepository.logout();
    }
    if(event==SignInAnonimousEvent()){
      _userRepository.login(AuthType.anonymous);
    }
    if(event==SignInGoogleEvent()){
      _userRepository.login(AuthType.google);
    }
  }

  void dispose() {
    _authController?.close();
    _eventsController?.close();
  }

}
