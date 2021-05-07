import 'dart:developer';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/transformers/firebase_user_to_user_entity_transformer.dart';

final _firebase = FirebaseAuth.instance;

Stream<User?> subscribeToViewer() {
  log('subscribeToViewer is called.');
  final viewerState = Get.find<ViewerState>();

  viewerState.setIsLoading(true);
  viewerState.hasBeenRequested = true;
  return _firebase.authStateChanges().map((user) {
    if (user != null) {
      viewerState.login(firebaseUserToUserEntityTransformer(user));
    }
    viewerState.setIsLoading(false);
  });
}
