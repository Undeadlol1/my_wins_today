import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_wins_today/repositories/get_user_by_id_repository.dart';
import 'package:my_wins_today/states/user_state.dart';

Future<void> getUser(String userId) async {
  log('getUser() is called.');
  final userState = Get.find<UserState>();

  userState.setIsLoading(true);
  await getUserById(userId).then(userState.setUser);
  userState.setIsLoading(false);
}
