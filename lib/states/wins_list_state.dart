import 'package:my_wins_today/entities/Win.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WinsListState extends GetxController {
  List<Win> wins = [];
  bool isLoading = true;

  void set(List<Win> payload) {
    this.wins = payload;
    update();
  }
}
