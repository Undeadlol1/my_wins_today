import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_wins_today/repositories/get_user_by_id_repository.dart';
import 'package:my_wins_today/repositories/get_wins_repository.dart';
import 'package:my_wins_today/states/user_state.dart';

Future<void> getUser(String userId) async {
  log('getUser() is called.');
  final userState = Get.find<UserState>();

  userState.setIsLoading(true);
  await Future.wait([
    getUserById(userId).then(userState.setUser),
    getWinsRepository(userId: userId).then(userState.setWins),
  ]);
  userState.setIsLoading(false);
}
