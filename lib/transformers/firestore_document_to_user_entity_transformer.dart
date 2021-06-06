import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/entities/user.dart';

User firestoreDocumentToUserEntityTransformer(DocumentSnapshot document) {
  final data = document.data()!;

  return User(
    id: document.id,
    email: data['email'],
    picture: data['picture'],
    createdAt: data['createdAt'],
    updatedAt: data['updatedAt'],
    displayName: data['displayName'],
  );
}
