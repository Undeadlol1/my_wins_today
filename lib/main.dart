import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/screens/main_screen.dart';

import 'StoriesList.dart';
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

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Something were thrown during Firebase initialisation.');
          print(snapshot.error);
          return MaterialApp(
            home: Center(
              child: Text('Firebase Error.'),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: MainScreen(myWinsToday: []),
            routes: {
              SignInScreen.path: (context) => SignInScreen(),
              CreateWinScreen.path: (context) => CreateWinScreen(wins: []),
            },
          );
        }

        return MaterialApp(
          home: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
