import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:my_wins_today/entities/user.dart';

User firebaseUserToUserEntityTransformer(FirebaseAuth.User firebaseUser) {
  final currentTimeInMilliseconds = DateTime.now().millisecondsSinceEpoch;

  return User(
    id: firebaseUser.uid,
    email: firebaseUser.email!,
    picture: firebaseUser.photoURL!,
    // NOTE: this is wrong.
    createdAt: currentTimeInMilliseconds,
    updatedAt: currentTimeInMilliseconds,
    displayName: firebaseUser.displayName!,
  );
}
