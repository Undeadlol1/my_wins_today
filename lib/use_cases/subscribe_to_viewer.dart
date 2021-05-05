import 'dart:developer';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/transformers/firebase_user_to_user_entity_transformer.dart';

final _firebase = FirebaseAuth.instance;

Stream<User?> subscribeToViewer() {
  log('subscribeToViewer is called.');
  final _viewerState = Get.find<ViewerState>();

  _viewerState.isLoading = true;
  _viewerState.hasBeenRequested = true;
  return _firebase.authStateChanges().map((user) {
    log('user: ' + user.toString());
    if (user != null) {
      _viewerState.login(firebaseUserToUserEntityTransformer(user));
    }
    return user;
  });
}
