import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:my_wins_today/entities/User.dart';

User firebaseUserToUserEntityTransformer(FirebaseAuth.User firebaseUser) {
  final currentTimeInMilliseconds = DateTime.now().millisecondsSinceEpoch;

  return User(
    id: firebaseUser.uid,
    email: firebaseUser.email!,
    picture: firebaseUser.photoURL!,
    // NOTE: this is intentionally wrong.
    // TODO: save currently logged in user locally.
    // then use this data to put in state during "subscribeToViewer"
    // on application start up.
    createdAt: currentTimeInMilliseconds,
    updatedAt: currentTimeInMilliseconds,
    displayName: firebaseUser.displayName!,
  );
}
