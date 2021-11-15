import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TawteenFirebaseUser {
  TawteenFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

TawteenFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TawteenFirebaseUser> tawteenFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TawteenFirebaseUser>(
        (user) => currentUser = TawteenFirebaseUser(user));
