import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';

Future logOut() async {
  final viewerState = Get.put(ViewerState());
  final winsListState = Get.put(WinsListState());

  viewerState.logout();
  winsListState.setMyWins([]);
  winsListState.setFriendsWins([]);

  return await FirebaseAuth.instance.signOut();
}
