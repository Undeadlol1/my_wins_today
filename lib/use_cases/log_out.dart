import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_wins_today/states/viewer_state.dart';

Future logOut() async {
  Get.put(ViewerState()).logout();
  return await FirebaseAuth.instance.signOut();
}
