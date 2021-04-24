import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/screens/main_screen.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';
import 'package:my_wins_today/streams/viewer_stream.dart';
import 'package:my_wins_today/use_cases/subscribe_to_friends_todays_wins.dart';

import 'create_win_screen.dart';

class MainScreenContainer extends StatelessWidget {
  const MainScreenContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: viewerStream(),
        builder: (_, AsyncSnapshot<User?> viewerSnapshot) {
          return StreamBuilder<List<Win>>(
              initialData: [],
              stream: viewerSnapshot.data == null
                  ? null
                  : subscribeToFriendsTodaysWins(
                      userId: viewerSnapshot.data!.uid,
                    ),
              builder: (_, AsyncSnapshot<List<Win>> winsSnapshot) {
                final isLoading =
                    winsSnapshot.connectionState == ConnectionState.waiting;

                return MainScreen(
                  isLoading: isLoading,
                  myWinsToday: winsSnapshot.data!.toList(),
                  onFABPress: () {
                    if (viewerSnapshot.data == null) {
                      Navigator.of(context).pushNamed(SignInScreen.path);
                    } else {
                      Navigator.of(context).pushNamed(CreateWinScreen.path);
                    }
                  },
                );
              });
        });
  }
}
