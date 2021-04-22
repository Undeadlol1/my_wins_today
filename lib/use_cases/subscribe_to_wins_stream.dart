import 'package:my_wins_today/entities/Win.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/states/wins_list_state.dart';

Stream<List<Win>> subscribeToWinsStream() {
  return FirebaseFirestore.instance
      .collection('wins')
      .snapshots(includeMetadataChanges: false)
      .map((snapshot) {
    final wins = _convertFirebaseDocumentsToWins(snapshot);
    WinsListState().set(wins);
    wins.sort(_sortFromNewestToOldest);
    return wins;
  });
}

List<Win> _convertFirebaseDocumentsToWins(QuerySnapshot snapshot) {
  List<Win> list = [];

  snapshot.docs.toList().forEach((document) {
    var data = document.data();
    list.add(Win(
      id: data['id'],
      title: data['title'],
      userId: data['userId'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    ));
  });

  return list;
}

int _sortFromNewestToOldest(first, second) {
  return first.createdAt.compareTo(second.createdAt);
}
