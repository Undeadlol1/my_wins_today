import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:my_wins_today/entities/win.dart';
import 'package:my_wins_today/DTOs/win_create_dto.dart';
import 'package:my_wins_today/utilities/generateId.dart';
import 'package:my_wins_today/utilities/log_and_throw_on_error.dart';

Future<Win> createWinRepository(WinCreateDTO winPayload) async {
  log('createWinRepository() is called.');

  final documentId = generateId();
  final currentTimeInMilliseconds = DateTime.now().millisecondsSinceEpoch;
  final winToBeCreated = Win(
    id: documentId,
    likedByUsers: [],
    title: winPayload.title,
    userId: winPayload.userId,
    isImportant: winPayload.isImportant,
    createdAt: currentTimeInMilliseconds,
    updatedAt: currentTimeInMilliseconds,
  );

  await FirebaseFirestore.instance
      .collection('wins')
      .doc(documentId)
      .set(winToBeCreated.toMap())
      .catchError(logAndThrowOnError);

  return winToBeCreated;
}
