import 'dart:developer' show log;

import 'package:my_wins_today/entities/User.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserState extends GetxController {
  User? data;
  bool isLoading = false;
  bool hasBeenRequested = false;

  set user(User? user) {
    log('set user is called.');
    data = user;
    isLoading = false;
    hasBeenRequested = true;
    update();
  }

  void reset() {
    log('userState.reset is called.');
    data = null;
    isLoading = false;
    hasBeenRequested = false;
    update();
  }

  void setIsLoading(bool value) {
    if (value != this.isLoading) {
      this.isLoading = value;
      update();
    }
  }
}
