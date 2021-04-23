import 'dart:developer';

import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/repositories/subscribe_to_wins_repository.dart';
import 'package:my_wins_today/states/wins_list_state.dart';

Stream<List<Win>> subscribeToTodaysWinsStream({required String? userId}) {
  log('subscribeToTodaysWinsStream is called.');
  log('userId: $userId');

  if (userId == null || userId.isEmpty) {
    return Stream.empty();
  } else {
    return subscribeToWinsRepository(userId: userId).map((wins) {
      wins.sort(_sortFromNewestToOldest);
      WinsListState().set(wins);
      return wins;
    });
  }
}

int _sortFromNewestToOldest(first, second) {
  return first.createdAt.compareTo(second.createdAt);
}
