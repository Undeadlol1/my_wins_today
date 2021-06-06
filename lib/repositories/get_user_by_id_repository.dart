import 'dart:async';
import 'dart:developer';

import 'package:my_wins_today/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/transformers/firestore_document_to_user_entity_transformer.dart';
import 'package:my_wins_today/utilities/log_and_throw_on_error.dart';

Future<User?> getUserById(String userId) async {
  log('getUserById is called.');

  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .get()
      .then(_transformAndReturnDocument)
      .catchError(logAndThrowOnError);
}

FutureOr<User?> _transformAndReturnDocument(firebaseUserDocument) {
  if (firebaseUserDocument.exists) {
    return firestoreDocumentToUserEntityTransformer(firebaseUserDocument);
  }
}
