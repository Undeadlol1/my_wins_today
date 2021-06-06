import 'dart:developer';
import 'package:my_wins_today/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:my_wins_today/utilities/log_and_throw_on_error.dart';

Future<User> createUserRepository(Firebase.User firebaseUser) async {
  log('createUserRepository() is called.');

  final String userId = firebaseUser.uid;
  final currentTimeInMilliseconds = DateTime.now().millisecondsSinceEpoch;
  final userToBeCreated = User(
    id: userId,
    email: firebaseUser.email!,
    picture: firebaseUser.photoURL!,
    createdAt: currentTimeInMilliseconds,
    updatedAt: currentTimeInMilliseconds,
    displayName: firebaseUser.displayName!,
  );

  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .set(userToBeCreated.toMap())
      .catchError(logAndThrowOnError);

  return userToBeCreated;
}
