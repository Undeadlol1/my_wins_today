import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/entities/Win.dart';

final firestore = FirebaseFirestore.instance;

Stream<List<Win>> subscribeToWinsRepository({required String userId}) {
  log('subscribeToWinsRepository is called.');
  final lastSixteenHours =
      DateTime.now().subtract(Duration(hours: 16)).millisecondsSinceEpoch;

  return firestore
      .collection('wins')
      .where('userId', isEqualTo: userId)
      .where('createdAt', isGreaterThan: lastSixteenHours)
      .snapshots()
      .map(_convertFirebaseDocumentsToWins);
}

List<Win> _convertFirebaseDocumentsToWins(QuerySnapshot snapshot) {
  List<Win> list = [];

  snapshot.docs.toList().forEach((document) {
    var data = document.data();
    list.add(Win(
      id: data['id'],
      title: data['title'],
      userId: data['userId'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    ));
  });

  return list;
}
