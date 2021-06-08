import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_wins_today/entities/win.dart';

class WinsListState extends GetxController {
  List<Win> myWins = [];
  bool isLoading = false;
  List<Win> friendsWins = [];

  void setMyWins(List<Win> payload) {
    this.myWins = payload;
    update();
  }

  void setFriendsWins(List<Win> payload) {
    this.friendsWins = payload;
    update();
  }

  void setLoading(bool value) {
    if (value != this.isLoading) {
      this.isLoading = value;
      update();
    }
  }
}
