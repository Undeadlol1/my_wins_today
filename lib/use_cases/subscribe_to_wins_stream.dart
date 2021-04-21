import 'package:my_wins_today/entities/Win.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TODO refactor
Stream<List<Win>> subscribeToWinsStream() {
  return FirebaseFirestore.instance
      .collection('wins')
      .snapshots(includeMetadataChanges: false)
      .map((event) {
    List<Win> list = [];
    event.docs.forEach((element) {
      var data = element.data();
      list.add(Win(
        id: data['id'],
        userId: data['userId'],
        title: data['title'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      ));
    });
    return list;
  });
}
