import 'package:my_wins_today/entities/Win.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wins_today/states/wins_list_state.dart';

Stream<List<Win>> subscribeToWinsStream() {
  return FirebaseFirestore.instance
      .collection('wins')
      .snapshots(includeMetadataChanges: false)
      .map((event) {
    final wins = _convertFirebaseDocumentsToWins(event);
    WinsListState().set(wins);
    wins.sort(_sortFromNewestToOldest);
    return wins;
  });
}

List<Win> _convertFirebaseDocumentsToWins(QuerySnapshot event) {
  List<Win> list = [];

  event.docs.toList().forEach((element) {
    var data = element.data();
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
