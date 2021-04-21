import 'package:uuid/uuid.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final uuid = Uuid();

class _WinCreationPayload {
  String title;
  String userId;

  _WinCreationPayload({
    required this.title,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'userId': this.userId,
    };
  }
}

class _CommonDatabaseFields {
  String id;
  int createdAt;
  int updatedAt;

  _CommonDatabaseFields({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });
}

class _PayloadCombinedWithDatabaseFields
    implements _CommonDatabaseFields, _WinCreationPayload {
  String id;
  String title;
  String userId;
  int createdAt;
  int updatedAt;

  _CommonDatabaseFields({
    required this.id,
    required this.title,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
}

class CreateWinRepository {
  CollectionReference winsCollection =
      FirebaseFirestore.instance.collection('wins');

  Future<Win> main(_WinCreationPayload winToCreate) async {
    final currentTimeInMilliseconds = DateTime.now().microsecondsSinceEpoch;
    final _CommonDatabaseFields databaseFields = _CommonDatabaseFields(
      id: uuid.v4(),
      createdAt: currentTimeInMilliseconds,
      updatedAt: currentTimeInMilliseconds,
    );

    final Map<String, dynamic> cominedFields = {
      ...databaseFields,
      ...winToCreate
    };
    await winsCollection
        .add(cominedFields)
        .then((value) => value)
        .catchError((error) => print("Failed to add a win: $error"));

    return cominedFields;
  }
}

final firstMap = {"1": "2"};
final secondMap = {"2": "3"};

final thirdMap = {
  ...firstMap,
  ...secondMap,
};
