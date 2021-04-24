import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:my_wins_today/global_dependencies.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/screens/main_screen_container.dart';

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

    return GlobalDependencies(
      child: GetMaterialApp(
        routes: _buildRoutes(),
        home: MainScreenContainer(),
      ),
    );
  }

  Map<String, Widget Function(BuildContext)> _buildRoutes() {
    return {
      SignInScreen.path: (context) => SignInScreen(),
      CreateWinScreen.path: (context) => CreateWinScreen(wins: []),
    };
  }
}
