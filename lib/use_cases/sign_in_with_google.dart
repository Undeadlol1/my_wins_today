import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_wins_today/repositories/create_user_repository.dart';
import 'package:my_wins_today/repositories/get_user_by_id_repository.dart';
import 'package:my_wins_today/states/viewer_state.dart';

final viewerState = Get.find<ViewerState>();

// https://firebase.flutter.dev/docs/auth/social/#google
Future<void> signInWithGoogle() async {
  log('signInWithGoogle is called.');

  viewerState.setIsLoading(true);

  await _signinToFirebaseViaGoogle();

  final firebaseUser = FirebaseAuth.instance.currentUser;
  final applicationUser = await getUserById(firebaseUser!.uid);

  if (applicationUser != null) {
    viewerState.login(applicationUser);
  } else {
    final createdUser = await createUserRepository(firebaseUser);
    viewerState.login(createdUser);
  }

  viewerState.setIsLoading(false);
}

Future<void> _signinToFirebaseViaGoogle() async {
  // Trigger the authentication flow
  final googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final googleAuth = await googleUser!.authentication;
  final credential = GoogleAuthProvider.credential(
    idToken: googleAuth.idToken,
    accessToken: googleAuth.accessToken,
  );
  await FirebaseAuth.instance.signInWithCredential(credential);
}
