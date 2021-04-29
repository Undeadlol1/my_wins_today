import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:my_wins_today/global_dependencies.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/screens/main_screen_container.dart';
import 'firebase_initializer.dart';
import 'screens/sign_in_screen.dart';
import 'stories_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const isStorybookEnabled = false;
    const isFirebaseEmulatorEnabled = false;

    if (isStorybookEnabled) {
      return StoriesList();
    }

    return FirebaseInitializer(
      onError: _logAndDisplayErrorText,
      onLoading: _buildLoadingIndicator,
      onDidInitilize: (_) {
        return GlobalDependencies(
          child: GetMaterialApp(
            routes: _buildRoutes(),
            home: MainScreenContainer(),
          ),
        );
      },
      shouldEmulatorStart: isFirebaseEmulatorEnabled,
    );
  }

  Map<String, Widget Function(BuildContext)> _buildRoutes() {
    return {
      SignInScreen.path: (context) => SignInScreen(),
      CreateWinScreen.path: (context) => CreateWinScreen(wins: []),
    };
  }

  Widget _buildLoadingIndicator() {
    return MaterialApp(
      home: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _logAndDisplayErrorText(Object? error) {
    log('Something were thrown during Firebase initialization.');
    log(error.toString());
    return MaterialApp(
      home: Center(
        child: Text('Firebase Error.'),
      ),
    );
  }
}
