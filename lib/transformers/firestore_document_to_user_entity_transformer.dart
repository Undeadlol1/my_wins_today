import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/entities/User.dart';

User firestoreDocumentToUserEntityTransformer(DocumentSnapshot document) {
  final data = document.data()!;

  return User(
    id: document.id,
    title: data['title'],
    email: data['email'],
    createdAt: data['data'],
    picture: data['picture'],
    isImportant: data['data'],
    updatedAt: data['updatedAt'],
    displayName: data['displayName'],
  );
}
