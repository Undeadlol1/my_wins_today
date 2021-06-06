import 'dart:developer';

import 'package:my_wins_today/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;

final _users = FirebaseFirestore.instance.collection('users');

Future<User> createUserRepository(Firebase.User firebaseUser) async {
  log('createUserRepository() is called.');

  final String id = firebaseUser.uid;
  final currentTimeInMilliseconds = DateTime.now().millisecondsSinceEpoch;
  final userToBeCreated = User(
    id: id,
    email: firebaseUser.email!,
    picture: firebaseUser.photoURL!,
    createdAt: currentTimeInMilliseconds,
    updatedAt: currentTimeInMilliseconds,
    displayName: firebaseUser.displayName!,
  );

  await _users.doc(id).set(userToBeCreated.toMap()).catchError((error) {
    log("Failed to add a user: $error");
    throw error;
  });

  return userToBeCreated;
}
