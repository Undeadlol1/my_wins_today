import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/screens/main_screen.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';
import 'package:my_wins_today/use_cases/subscribe_to_friends_todays_wins.dart';

import 'create_win_screen.dart';

class MainScreenContainer extends StatelessWidget {
  const MainScreenContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewerState>(
      // init: ViewerState(),
      builder: (viewerState) {
        log('viewerState.isLoading: ' + viewerState.isLoading.toString());
        log('viewerState.userId: ' + viewerState.userId.toString());
        // log('viewerState.viwer: ' + viewerState.viewer.toString());
        final winsListState = Get.find<WinsListState>();

        return StreamBuilder<List<Win>>(
            initialData: [],
            stream: subscribeToFriendsTodaysWins(
              userId: viewerState.userId,
            ),
            builder: (_, AsyncSnapshot<List<Win>> winsSnapshot) {
              final isLoading =
                  winsListState.isLoading || viewerState.isLoading;

              return MainScreen(
                isLoading: isLoading,
                myWinsToday: winsListState.friendsWins,
                onFABPress: () {
                  if (viewerState.viewer == null) {
                    Navigator.of(context).pushNamed(SignInScreen.path);
                  } else {
                    Navigator.of(context).pushNamed(CreateWinScreen.path);
                  }
                },
              );
            });
      },
    );
  }
}
