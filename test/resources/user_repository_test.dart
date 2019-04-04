import 'package:devfest_flutter_app/src/models/user.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:devfest_flutter_app/src/resources/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../consts.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}
class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}
class MockFirebaseUser extends Mock implements FirebaseUser {}

main() {
  group('FirebaseUserRepository', () {
    test('should log the user in anonymously', () async {
      final auth = MockFirebaseAuth();
      final repository = FirebaseUserRepository(auth, null);
      final user = MockFirebaseUser();

      when(user.uid).thenAnswer((_) => TEST_ID);
      when(user.displayName).thenAnswer((_) => TEST_NAME);

      when(auth.signInAnonymously())
          .thenAnswer((_) => Future.value(user));



      expect(await repository.login(AuthType.anonymous), TypeMatcher<User>());
    });

    test('should log the user in google account', () async {
      final auth = MockFirebaseAuth();
      final googleSignIn = MockGoogleSignIn();
      final googleUser= MockGoogleSignInAccount();
      final googleAuth= MockGoogleSignInAuthentication();
      final repository = FirebaseUserRepository(auth, googleSignIn);

      final user = MockFirebaseUser();

      when(user.uid).thenAnswer((_) => TEST_ID);
      when(user.displayName).thenAnswer((_) => TEST_NAME);

      when(googleSignIn.signIn()).thenAnswer((_)=> Future.value(googleUser));
      when(googleUser.authentication).thenAnswer((_)=> Future.value(googleAuth));
      when(auth.signInWithCredential(GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken)))
          .thenAnswer((_) => Future.value(user));

      expect(await repository.login(AuthType.google), TypeMatcher<User>());
    });

  });
}

