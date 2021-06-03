import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:my_wins_today/screens/create_win_screen_container.dart';
import 'package:my_wins_today/screens/main_screen.dart';
import 'package:my_wins_today/screens/user_screen.dart';
import 'package:my_wins_today/screens/user_screen_container.dart';

import 'firebase_initializer.dart';
import 'global_dependencies.dart';
import 'screens/main_screen_container.dart';
import 'screens/sign_in_screen.dart';
import 'stories_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const isStorybookEnabled = true;
    const isFirebaseEmulatorEnabled = false;

    if (isStorybookEnabled) {
      return StoriesList();
    }

    return FirebaseInitializer(
      onError: _logAndDisplayErrorText,
      onLoading: _buildLoadingIndicator,
      shouldEmulatorStart: isFirebaseEmulatorEnabled,
      onDidInitilize: (_) {
        return GlobalDependencies(
          child: GetMaterialApp(
            getPages: _buildRoutes(),
            initialRoute: MainScreen.path,
            theme: ThemeData.light(),
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData.dark(),
          ),
        );
      },
    );
  }

  List<GetPage<dynamic>>? _buildRoutes() {
    return [
      GetPage(
        name: MainScreen.path,
        page: () => MainScreenContainer(),
      ),
      GetPage(
        name: SignInScreen.path,
        page: () => SignInScreen(),
      ),
      GetPage(
        name: CreateWinScreenContainer.path,
        page: () => CreateWinScreenContainer(),
      ),
      GetPage(
        name: UserScreen.path + '/:userId',
        page: () => UserScreenContainer(),
      ),
    ];
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
