import 'package:devfest_flutter_app/src/models/user.dart';
import 'package:devfest_flutter_app/src/resources/abstracts/abstract_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  const FirebaseUserRepository(this.auth, this.googleSignIn);

  @override
  Future<User> login(AuthType authType) {
    if (authType == AuthType.google) {
      return _signInWithGoogle();
    }
    if (authType == AuthType.anonymous) {
      return _signInAnonymously();
    }
    throw("authorization type is unknown");
  }


  Stream<User> getAuthorizedUser() =>
      auth.onAuthStateChanged.map((user) =>
      user != null
          ? _convertFirebaseUserToUser(user)
          : null);

  Future<User> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser
        ?.authentication;
    return _convertFutureResult(auth.signInWithGoogle(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    ));
  }

  Future<User> _signInAnonymously() async {
    return _convertFutureResult(auth.signInAnonymously());
  }

  User _convertFirebaseUserToUser(FirebaseUser firebaseUser) =>
      User(
        id: firebaseUser.uid,
        name: firebaseUser.displayName,
        photoUrl: firebaseUser.photoUrl,
      );

  Future<User> _convertFutureResult(Future<FirebaseUser> firebaseUser) =>
      firebaseUser
          .asStream()
          .map(_convertFirebaseUserToUser)
          .first;
}
