import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/screens/main_screen.dart';

import 'stories_list.dart';
import 'screens/sign_in_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Application());
}

class Application extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    const _isStorybookEnabled = false;
    if (_isStorybookEnabled) {
      return StoriesList();
    }

    return GetMaterialApp(
      routes: _buildRoutes(),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _logAndDisplayErrorText(snapshot);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MainScreen(
              myWinsToday: [],
              onFABPress: () {},
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Map<String, Widget Function(BuildContext)> _buildRoutes() {
    return {
      SignInScreen.path: (context) => SignInScreen(),
      CreateWinScreen.path: (context) => CreateWinScreen(wins: []),
    };
  }

  Widget _logAndDisplayErrorText(AsyncSnapshot<Object?> snapshot) {
    log('Something were thrown during Firebase initialization.');
    log(snapshot.error.toString());
    return Center(child: Text('Firebase Error.'));
  }
}
