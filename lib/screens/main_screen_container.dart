import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/screens/main_screen.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';
import 'package:my_wins_today/use_cases/create_win.dart';
import 'package:my_wins_today/use_cases/subscribe_to_wins_stream.dart';

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
      builder: (viewerState) => GetBuilder<WinsListState>(
        builder: (winsListState) {
          final isLoading = winsListState.isLoading || viewerState.isLoading;

          if (_shouldVidwerSubscribeToFriends(viewerState)) {
            log('About to subscribe to friends wins.');
            Future.microtask(() {
              setState(() => _isSubscrbeFunctionInitiated = true);
              subscribeToMyOwnTodaysWins().listen((_) => {});
            });
          }

          return MainScreen(
            friendsList: [],
            isLoading: isLoading,
            onCreateWinSubmit: createWin,
            myWinsToday: winsListState.myWins,
          );
        },
      ),
    );
  }

  bool _shouldVidwerSubscribeToFriends(ViewerState viewerState) {
    return !_isSubscrbeFunctionInitiated &&
        viewerState.hasBeenRequested &&
        !viewerState.isLoading &&
        viewerState.userId!.isNotEmpty;
  }
}
