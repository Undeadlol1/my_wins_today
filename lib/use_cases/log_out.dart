import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';

Future logOut() async {
  final viewerState = Get.find<ViewerState>();
  final winsListState = Get.find<WinsListState>();

  viewerState.logout();
  winsListState.setMyWins([]);
  winsListState.setFriendsWins([]);

  // TODO: use cases must not depend on libraries.
  return await FirebaseAuth.instance.signOut();
}
