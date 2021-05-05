import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getViewerId() async {
  log('getViewerId is called');
  final userId = FirebaseAuth.instance.currentUser?.uid;
  return userId == null ? '' : userId;
}
