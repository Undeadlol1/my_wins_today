import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../entities/Win.dart';
import '../widgets/layout.dart';
import '../widgets/WinsList.dart';

class MainScreen extends StatelessWidget {
  final List<Win> myWinsToday;
  const MainScreen({Key? key, required this.myWinsToday}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: _stream(),
        builder: (_, snapshot) {
          final auth = snapshot.data;
          final isAuthLoading =
              snapshot.connectionState == ConnectionState.waiting;

          _printAuthInfo(auth);

          return Layout(
            title: 'Список побед',
            body: WinsList(
              wins: this.myWinsToday,
              isLoading: isAuthLoading,
            ),
          );
        });
  }

  Stream<User?> _stream() {
    return FirebaseAuth.instance.authStateChanges();
  }

  void _printAuthInfo(User? auth) {
    if (auth == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      print('Name of current user is: ' + auth.displayName.toString());
    }
  }
}
