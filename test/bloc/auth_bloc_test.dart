import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc.dart';
import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc_event.dart';
import 'package:devfest_flutter_app/src/bloc/auth/auth_bloc_state.dart';
import 'package:devfest_flutter_app/src/models/user.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}
class MockFirebaseUser extends Mock implements FirebaseUser{}

void main() {
  AuthBloc authBloc;
  MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    authBloc = AuthBloc(userRepository: userRepository);
  });

  test('initial state is correct', () {
    expect(authBloc.initialState, AuthInit());
  });

  test('dispose does not emit new states', () {
    expectLater(
      authBloc.state,
      emitsInOrder([]),
    );
    authBloc.dispose();
  });

  group('LoggedOut', () {
    test('emits [init, logged out] for uninitialized user', () {
      final User user = null;
      final expectedResponse = [
        AuthInit(),
        AuthLoggedOut()
      ];

      when(userRepository.getAuthorizedUser()).thenAnswer((_) => Future.value(user).asStream());

      expectLater(
        authBloc.state,
        emitsInOrder(expectedResponse),
      );

      authBloc.dispatch(AppStarted());
    });
  });

  group('LoggedIn', () {
    test(
        'emits [init, logged in] for initialized user',
        () {
          final user = User(id: '1', name: 'test');
      final expectedResponse = [
        AuthInit(),
        AuthLoggedIn(user: user)
      ];

      when(userRepository.getAuthorizedUser()).thenAnswer((_) => Future.value(user).asStream());

      expectLater(
        authBloc.state,
        emitsInOrder(expectedResponse),
      );

      authBloc.dispatch(AppStarted());
    });
  });

;
}
