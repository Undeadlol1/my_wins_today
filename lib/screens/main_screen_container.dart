import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/screens/main_screen.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';
import 'package:my_wins_today/states/wins_list_state.dart';
import 'package:my_wins_today/use_cases/subscribe_to_friends_todays_wins.dart';

import 'create_win_screen.dart';

class MainScreenContainer extends StatelessWidget {
  const MainScreenContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewerState>(builder: (viewerState) {
      final winsListState = Get.put(WinsListState());

      return StreamBuilder<List<Win>>(
          initialData: [],
          stream: subscribeToFriendsTodaysWins(
            userId: viewerState.viewer?.uid ?? '',
          ),
          builder: (_, AsyncSnapshot<List<Win>> winsSnapshot) {
            final isLoading = winsListState.isLoading || viewerState.isLoading;

            log('MainScreenContainer > isLoading: $isLoading');

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
    });
  }
}
