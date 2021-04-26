import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ViewerState extends GetxController {
  User? viewer;
  String? userId = '';
  bool isLoading = true;

  void login(User user) {
    log('viewer.login is called.');
    viewer = user;
    isLoading = false;
    userId = user.uid;
    update();
  }

  void logout() {
    log('viewer.logout is called.');
    userId = '';
    viewer = null;
    isLoading = false;
    update();
  }

  void setIsLoading(bool state) {
    this.isLoading = state;
    update();
  }
}
