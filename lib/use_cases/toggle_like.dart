import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_wins_today/entities/win.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/repositories/update_win_repository.dart';

Future<Win> toggleLike({required Win winToUpdate}) async {
  log('toggleLike() is called.');

  final userId = Get.find<ViewerState>().userId;

  if (userId == null) {
    log('User is not signed in. Returning.');
    return winToUpdate;
  }

  if (winToUpdate.likedByUsers.contains(userId)) {
    winToUpdate.likedByUsers.remove(userId);
  } else {
    winToUpdate.likedByUsers.add(userId);
  }

  return updateWinRepository(winToUpdate);
}
