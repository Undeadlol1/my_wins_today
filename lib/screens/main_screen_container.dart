import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/screens/main_screen.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';
import 'package:my_wins_today/use_cases/subscribe_to_friends_todays_wins.dart';

import 'create_win_screen.dart';

class MainScreenContainer extends StatefulWidget {
  const MainScreenContainer({Key? key}) : super(key: key);

  @override
  _MainScreenContainerState createState() => _MainScreenContainerState();
}

class _MainScreenContainerState extends State<MainScreenContainer> {
  bool _isSubscrbeFunctionInitiated = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewerState>(
      // init: ViewerState(),
      builder: (viewerState) => GetBuilder<WinsListState>(
        // init: ViewerState(),
        builder: (winsListState) {
          final isLoading = winsListState.isLoading || viewerState.isLoading;

          if (_shouldVidwerSubscribeToFriends(viewerState)) {
            log('About to subscribe to friends wins.');
            Future.microtask(() {
              setState(() => _isSubscrbeFunctionInitiated = true);
              subscribeToFriendsTodaysWins().listen((_) => {});
            });
          }

          return MainScreen(
            isLoading: isLoading,
            myWinsToday: winsListState.friendsWins,
            onFABPress: () {
              if (viewerState.viewer == null) {
                Navigator.of(context).popAndPushNamed(SignInScreen.path);
              } else {
                Navigator.of(context).popAndPushNamed(CreateWinScreen.path);
              }
            },
          );
        },
      ),
    );
  }

  bool _shouldVidwerSubscribeToFriends(ViewerState viewerState) {
    return !_isSubscrbeFunctionInitiated &&
        viewerState.hasBeenRequested &&
        !viewerState.isLoading &&
        viewerState.userId != null;
  }
}
