import 'package:firebase_auth/firebase_auth.dart';

Stream<User?> viewerStream() {
  return FirebaseAuth.instance.authStateChanges();
}
