import 'dart:developer';

import 'package:my_wins_today/DTOs/win_create_dto.dart';
import 'package:uuid/uuid.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final uuid = Uuid();

Future<Win> createWinRepository(WinCreateDTO winPayload) async {
  log('createWinRepository() is called.');

  final CollectionReference winsCollection =
      FirebaseFirestore.instance.collection('wins');
  final currentTimeInMilliseconds = DateTime.now().millisecondsSinceEpoch;

  final Win winToBeCreated = Win(
    id: uuid.v4(),
    title: winPayload.title,
    userId: winPayload.userId,
    createdAt: currentTimeInMilliseconds,
    updatedAt: currentTimeInMilliseconds,
  );

  await winsCollection.add(winToBeCreated.toMap()).catchError((error) {
    log("Failed to add a win: $error");
    throw error;
  });

  return winToBeCreated;
}
