import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'stories_list.dart';
import 'global_dependencies.dart';
import 'firebase_initializer.dart';
import 'screens/sign_in_screen.dart';
import 'screens/create_win_screen.dart';
import 'screens/main_screen_container.dart';

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
      CreateWinScreen.path: (context) => CreateWinScreen(
            wins: [],
            onSubmit: ({required bool isImportant, required String title}) {},
          ),
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
