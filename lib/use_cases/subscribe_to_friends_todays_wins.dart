import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/repositories/subscribe_to_wins_repository.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';

const mishasId = 'TVwWONM7LVgCI6NnBiT4bIpbRFZ2';
const ritasId = 'TAco9JE8NXeooQsVDPsMIHAugpk1';

final viewerState = Get.find<ViewerState>();
final winsListState = Get.find<WinsListState>();

Stream<List<Win>> subscribeToFriendsTodaysWins() {
  log('subscribeToFriendsTodaysWins is called.');

  final userId = viewerState.userId;

  if (userId == null || userId.isEmpty) {
    return Stream.value([]);
  }

  winsListState.setLoading(true);
  return subscribeToWinsRepository(
    userId: userId == mishasId ? ritasId : mishasId,
  ).map((wins) {
    wins.sort(_sortFromNewestToOldest);
    winsListState.setFriendsWins(wins);
    winsListState.setLoading(false);
    return wins;
  });
}

int _sortFromNewestToOldest(first, second) {
  return first.createdAt.compareTo(second.createdAt);
}
