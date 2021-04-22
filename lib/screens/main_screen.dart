import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_wins_today/streams/viewer_stream.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/use_cases/subscribe_to_wins_stream.dart';

import '../entities/Win.dart';
import '../widgets/layout.dart';
import '../widgets/wins_list.dart';

class MainScreen extends StatelessWidget {
  static const path = '/';

  final List<Win> myWinsToday;
  const MainScreen({Key? key, required this.myWinsToday}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: viewerStream(),
        builder: (_, AsyncSnapshot<User?> viewerSnapshot) {
          return StreamBuilder<List<Win>>(
              initialData: [],
              stream: viewerSnapshot.data == null
                  ? null
                  : subscribeToTodaysWinsStream(
                      userId: viewerSnapshot.data!.uid),
              builder: (_, AsyncSnapshot<List<Win>> winsSnapshot) {
                final isLoading =
                    winsSnapshot.connectionState == ConnectionState.waiting;

                return Layout(
                  title: 'Список побед',
                  body: WinsList(
                    isLoading: isLoading,
                    wins: winsSnapshot.data!.toList(),
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      if (viewerSnapshot.data == null) {
                        Navigator.of(context).pushNamed(SignInScreen.path);
                      } else {
                        Navigator.of(context).pushNamed(CreateWinScreen.path);
                      }
                    },
                  ),
                );
              });
        });
  }
}
