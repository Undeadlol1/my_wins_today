import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/states/wins_list_state.dart';
import 'package:my_wins_today/repositories/subscribe_to_wins_repository.dart';

Stream<List<Win>> subscribeToMyOwnTodaysWins({required String? userId}) {
  log('subscribeToTodaysWinsStream is called.');
  log('userId: $userId');

  WinsListState winsListState = Get.put(WinsListState());

  if (userId == null || userId.isEmpty) {
    return Stream.empty();
  } else {
    winsListState.setLoading(true);
    return subscribeToWinsRepository(userId: userId).map((wins) {
      wins.sort(_sortFromNewestToOldest);
      winsListState.setLoading(false);
      winsListState.setMyWins(wins);
      return wins;
    });
  }
}

int _sortFromNewestToOldest(first, second) {
  return first.createdAt.compareTo(second.createdAt);
}
