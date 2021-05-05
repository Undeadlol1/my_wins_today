import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_wins_today/entities/User.dart';

class ViewerState extends GetxController {
  User? viewer;
  String? userId = '';
  bool isLoading = true;
  bool hasBeenRequested = false;

  void login(User user) {
    log('viewer.login is called.');
    viewer = user;
    userId = user.id;
    isLoading = false;
    hasBeenRequested = true;
    update();
  }

  void logout() {
    log('viewer.logout is called.');
    userId = '';
    viewer = null;
    isLoading = false;
    update();
  }

  void setIsLoading(bool value) {
    if (value != this.isLoading) {
      this.isLoading = value;
      update();
    }
  }
}
