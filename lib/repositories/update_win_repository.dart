import 'dart:developer' show log;
import 'package:my_wins_today/entities/win.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/utilities/log_and_throw_on_error.dart';

final winsCollection = FirebaseFirestore.instance.collection('wins');

Future<Win> updateWinRepository(Win updatedWin) async {
  log('updateWinRepository() is called.');

  updatedWin.updatedAt = DateTime.now().millisecondsSinceEpoch;

  await winsCollection
      .doc(updatedWin.id)
      .update(updatedWin.toMap())
      .catchError(logAndThrowOnError);

  return updatedWin;
}
