import 'package:devfest_flutter_app/src/bloc/login/sign_in_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/login/sign_in_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/login/sign_in_bloc_state.dart';
import 'package:devfest_flutter_app/src/models/user.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  SignInBloc signInBloc;
  MockUserRepository userRepository;
  User user;

  setUp(() {
    user = User(id: '1', name: 'Test');
    userRepository = MockUserRepository();
    signInBloc = SignInBloc(
      userRepository: userRepository,
    );
  });

  test('initial state is correct', () {
    expect(SignInInitial(), signInBloc.initialState);
  });

  test('dispose does not emit new states', () {
    expectLater(
      signInBloc.state,
      emitsInOrder([]),
    );
    signInBloc.dispose();
  });

  group('AnySignInButtonPressed', () {
    test('emits anonimous sign in', () {
      final expectedResponse = [
        SignInInitial(),
        SignInLoading(),
        SignInInitial(),
      ];

      when(userRepository.login(AuthType.anonymous))
          .thenAnswer((_) => Future.value(user));

      expectLater(
        signInBloc.state,
        emitsInOrder(expectedResponse),
      );

      signInBloc.dispatch(AnonymousSignInButtonPressed());
    });

    test('emits google sign in', () {
      final expectedResponse = [
        SignInInitial(),
        SignInLoading(),
        SignInInitial(),
      ];

      when(userRepository.login(AuthType.google))
          .thenAnswer((_) => Future.value(user));

      expectLater(
        signInBloc.state,
        emitsInOrder(expectedResponse),
      );

      signInBloc.dispatch(AnonymousSignInButtonPressed());
    });
  });
}
