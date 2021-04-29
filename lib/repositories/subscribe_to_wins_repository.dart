import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/entities/Win.dart';

final _firestore = FirebaseFirestore.instance;

Stream<List<Win>> subscribeToWinsRepository({required String userId}) {
  log('subscribeToWinsRepository is called.');
  final lastSixteenHours =
      DateTime.now().subtract(Duration(hours: 16)).millisecondsSinceEpoch;

  return _firestore
      .collection('wins')
      .where('userId', isEqualTo: userId)
      .where('createdAt', isGreaterThan: lastSixteenHours)
      .snapshots()
      .map(_convertFirebaseDocumentsToWins)
      .handleError((error) => log(error.toString()));
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
      isImportant: data['isImportant'],
    ));
  });

  return list;
}
