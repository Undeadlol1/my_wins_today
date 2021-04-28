import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/DTOs/win_create_dto.dart';
import 'package:my_wins_today/utilities/generateId.dart';

Future<Win> createWinRepository(WinCreateDTO winPayload) async {
  log('createWinRepository() is called.');

  final currentTimeInMilliseconds = DateTime.now().millisecondsSinceEpoch;
  final CollectionReference winsCollection =
      FirebaseFirestore.instance.collection('wins');

  final Win winToBeCreated = Win(
    id: generateId(),
    title: winPayload.title,
    userId: winPayload.userId,
    isImportant: winPayload.isImportant,
    createdAt: currentTimeInMilliseconds,
    updatedAt: currentTimeInMilliseconds,
  );

  await winsCollection.add(winToBeCreated.toMap()).catchError((error) {
    log("Failed to add a win: $error");
    throw error;
  });

  return winToBeCreated;
}
