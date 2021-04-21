import 'package:my_wins_today/DTOs/win_create_dto.dart';
import 'package:uuid/uuid.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final uuid = Uuid();

Future<Win> createWinRepository(WinCreateDTO winPayload) async {
  final CollectionReference _winsCollection =
      FirebaseFirestore.instance.collection('wins');
  final currentTimeInMilliseconds = DateTime.now().microsecondsSinceEpoch;

  final Win winToBeCreated = Win(
    id: uuid.v4(),
    title: winPayload.title,
    userId: winPayload.userId,
    createdAt: currentTimeInMilliseconds,
    updatedAt: currentTimeInMilliseconds,
  );

  await _winsCollection.add(winToBeCreated.toMap()).catchError((error) {
    print("Failed to add a win: $error");
    throw error;
  });

  return winToBeCreated;
}
