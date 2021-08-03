import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_wins_today/entities/win.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';
import 'package:my_wins_today/repositories/subscribe_to_wins_repository.dart';

Stream<List<Win>> subscribeToMyOwnTodaysWins() {
  log('subscribeToTodaysWinsStream is called.');

  final userId = Get.find<ViewerState>().userId;
  final winsState = Get.find<WinsListState>();

  winsState.setLoading(true);

  if (userId == null || userId.isEmpty) {
    winsState.setLoading(false);
    return Stream.empty();
  }

  return subscribeToWinsRepository(userId: userId).map(
    (wins) {
      wins.sort(_sortFromNewestToOldest);
      winsState.setMyWins(wins);
      winsState.setLoading(false);
      return wins;
    },
  );
}

int _sortFromNewestToOldest(first, second) {
  return first.createdAt.compareTo(second.createdAt);
}
