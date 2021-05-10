import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/screens/user_screen.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';
import 'package:my_wins_today/use_cases/subscribe_to_friends_todays_wins.dart';

class UserScreenContainer extends StatefulWidget {
  const UserScreenContainer({Key? key}) : super(key: key);

  @override
  _UserScreenContainerState createState() => _UserScreenContainerState();
}

class _UserScreenContainerState extends State<UserScreenContainer> {
  bool _isSubscrbeFunctionInitiated = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewerState>(
      builder: (viewerState) => GetBuilder<WinsListState>(
        builder: (winsListState) {
          final String? userId = Get.parameters['userId'];
          final isLoading = winsListState.isLoading || viewerState.isLoading;

          if (_shouldVidwerSubscribeToFriends(viewerState)) {
            log('About to subscribe to friends wins.');
            Future.microtask(() {
              setState(() => _isSubscrbeFunctionInitiated = true);
              subscribeToFriendsTodaysWins().listen((_) => {});
            });
          }

          return UserScreen(
            userId: userId!,
            isLoading: isLoading,
            winsToday: winsListState.myWins,
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
