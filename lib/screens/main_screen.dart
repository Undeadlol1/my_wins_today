import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_wins_today/streams/viewer_stream.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';

import '../entities/Win.dart';
import '../widgets/layout.dart';
import '../widgets/WinsList.dart';

class MainScreen extends StatelessWidget {
  static const path = '/';

  final List<Win> myWinsToday;
  const MainScreen({Key? key, required this.myWinsToday}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: viewerStream(),
        builder: (_, snapshot) {
          final isAuthLoading =
              snapshot.connectionState == ConnectionState.waiting;

          return Layout(
            title: 'Список побед',
            body: WinsList(
              wins: this.myWinsToday,
              isLoading: isAuthLoading,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CreateWinScreen.path),
            ),
          );
        });
  }
}
