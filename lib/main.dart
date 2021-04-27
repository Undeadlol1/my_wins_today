import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:my_wins_today/global_dependencies.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/screens/main_screen.dart';
import 'package:my_wins_today/screens/main_screen_container.dart';
import 'package:my_wins_today/use_cases/subscribe_to_viewer.dart';

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
    const _isStorybookEnabled = false;
    if (_isStorybookEnabled) {
      return StoriesList();
    }

    return FirebaseInitializer(
      onError: (_, __) => Text('123'),
      onLoading: (loadingContext) => Center(
        child: Container(
          width: 100.0,
          height: 100.0,
          child: CircularProgressIndicator(),
        ),
      ),
      onDidInitilize: (didInitContext, _) {
        return StreamBuilder<void>(
          stream: subscribeToViewer(),
          builder: (context, snapshot) {
            return GetMaterialApp(
              routes: _buildRoutes(),
              initialRoute: MainScreen.path,
            );
          },
        );
      },
    );

    // return GlobalDependencies(
    //   child: MaterialApp(
    //     routes: _buildRoutes(),
    //     initialRoute: MainScreen.path,
    //   ),
    // );
  }

  Map<String, Widget Function(BuildContext)> _buildRoutes() {
    return {
      MainScreen.path: (context) => MainScreenContainer(),
      SignInScreen.path: (context) => SignInScreen(),
      CreateWinScreen.path: (context) => CreateWinScreen(wins: []),
    };
  }
}
