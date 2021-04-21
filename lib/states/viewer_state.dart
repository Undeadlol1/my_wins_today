import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ViewerState extends GetxController {
  User? viewer;
  bool isLoading = true;

  void login(User user) {
    viewer = user;
    isLoading = false;
    update();
  }

  void logout() {
    viewer = null;
    isLoading = false;
    update();
  }

  void setIsLoading(bool state) {
    this.isLoading = state;
    update();
  }
}
