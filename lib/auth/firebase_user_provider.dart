import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AmbassadeursFirebaseUser {
  AmbassadeursFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

AmbassadeursFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AmbassadeursFirebaseUser> ambassadeursFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AmbassadeursFirebaseUser>(
            (user) => currentUser = AmbassadeursFirebaseUser(user));
