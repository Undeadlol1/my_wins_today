import 'dart:developer';

import 'package:my_wins_today/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/transformers/firestore_document_to_user_entity_transformer.dart';

final _users = FirebaseFirestore.instance.collection('users');

Future<User?> getUserById(String userId) async {
  log('getUserById is called.');

  return await _users
      .doc(userId)
      .get()
      .catchError(_logOnError)
      .then((firebaseUserDocument) {
    if (firebaseUserDocument.exists) {
      return firestoreDocumentToUserEntityTransformer(firebaseUserDocument);
    }
  });
}

_logOnError(error) {
  log("Failed to get a user: $error");
  throw error;
}
