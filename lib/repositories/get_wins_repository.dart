import 'dart:developer';

import 'package:my_wins_today/entities/win.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/transformers/firebase_win_documents_to_win_entities_transformer.dart';

final _winsCollection = FirebaseFirestore.instance.collection('wins');

Future<List<Win>> getWinsRepository({String userId = ''}) async {
  log('getWinsRepository() is called.');

  final lastSixteenHours =
      DateTime.now().subtract(Duration(hours: 16)).millisecondsSinceEpoch;

  return _winsCollection
      .where('userId', isEqualTo: userId)
      .where('createdAt', isGreaterThan: lastSixteenHours)
      .get()
      .then(firebaseWinDocumentsToWinEntities)
      .catchError((error) {
    log("Failed to fetch wins: $error");
    throw error;
  });
}
