import 'dart:developer' show log;
import 'package:my_wins_today/entities/win.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final winsCollection = FirebaseFirestore.instance.collection('wins');

Future<Win> updateWinRepository(Win updatedWin) async {
  log('updateWinRepository() is called.');

  updatedWin.updatedAt = DateTime.now().millisecondsSinceEpoch;

  await winsCollection
      .doc(updatedWin.id)
      .update(updatedWin.toMap())
      .catchError((error) {
    log("Failed to update a win: $error");
    throw error;
  });

  return updatedWin;
}
