import 'dart:developer';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_wins_today/states/viewer_state.dart';

Stream<void> subscribeToViewer() {
  log('subscribeToViewer is called.');
  final viewerState = Get.put(ViewerState());

  return FirebaseAuth.instance.authStateChanges().map((user) {
    log('user is logged in: ' + (user == null).toString());
    if (user != null) {
      viewerState.login(user);
    }
  });
}
