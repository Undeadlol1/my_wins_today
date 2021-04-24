import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:async_builder/async_builder.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/screens/main_screen_container.dart';

import 'screens/sign_in_screen.dart';
import 'stories_list.dart';

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
      home: AsyncBuilder<FirebaseApp>(
        future: _initialization,
        builder: (context, value) => MainScreenContainer(),
        waiting: (context) => Center(child: CircularProgressIndicator()),
        error: (context, error, stackTrace) => _logAndDisplayErrorText(error),
      ),
    );
  }

  Map<String, Widget Function(BuildContext)> _buildRoutes() {
    return {
      SignInScreen.path: (context) => SignInScreen(),
      CreateWinScreen.path: (context) => CreateWinScreen(wins: []),
    };
  }

  Widget _logAndDisplayErrorText(Object error) {
    log('Something were thrown during Firebase initialization.');
    log(error.toString());
    return Center(child: Text('Firebase Error.'));
  }
}
