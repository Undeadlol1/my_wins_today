import 'dart:async';

import 'package:get/get.dart';
import 'package:my_wins_today/entities/win.dart';
import 'package:my_wins_today/DTOs/win_create_dto.dart';
import 'package:my_wins_today/repositories/create_win_repository.dart';
import 'package:my_wins_today/states/viewer_state.dart';

Future<Win?> createWin({
  required String title,
  required bool isImportant,
}) async {
  final userId = Get.find<ViewerState>().userId;

  if (userId != null && userId.isNotEmpty) {
    return createWinRepository(WinCreateDTO(
      title: title,
      userId: userId,
      isImportant: isImportant,
    ));
  } else {
    return Future.value();
  }
}
