import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/entities/Win.dart';

List<Win> firebaseWinDocumentsToWinEntities(QuerySnapshot snapshot) {
  log('Repository responded with ${snapshot.docs.length.toString()} documents.');

  List<Win> list = [];

  snapshot.docs.toList().forEach((document) {
    var data = document.data();
    list.add(Win(
      id: data['id'],
      title: data['title'] ?? '',
      userId: data['userId'] ?? '',
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      likedByUsers: data['likedByUsers'] == null
          ? []
          : List<String>.from(data['likedByUsers']),
      isImportant: data['isImportant'] ?? false,
    ));
  });

  return list;
}
