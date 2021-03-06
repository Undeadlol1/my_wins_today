import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/entities/win.dart';
import 'package:my_wins_today/transformers/firebase_win_documents_to_win_entities_transformer.dart';
import 'package:my_wins_today/utilities/log_and_throw_on_error.dart';

Stream<List<Win>> subscribeToWinsRepository({required String userId}) {
  log('subscribeToWinsRepository is called.');
  log('Requested userId is: $userId');

  final firestore = FirebaseFirestore.instance;
  final lastSixteenHours =
      DateTime.now().subtract(Duration(hours: 16)).millisecondsSinceEpoch;

  return firestore
      .collection('wins')
      .where('userId', isEqualTo: userId)
      .where('createdAt', isGreaterThan: lastSixteenHours)
      .snapshots()
      .map(firebaseWinDocumentsToWinEntities)
      .handleError(logAndThrowOnError);
}
