import 'package:firebase_auth/firebase_auth.dart';

Future logOut() async {
  return await FirebaseAuth.instance.signOut();
}
