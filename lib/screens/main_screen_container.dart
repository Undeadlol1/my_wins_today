import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/entities/User.dart';
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
  static final List<User> _friends = [
    User(
      updatedAt: 1620244715861,
      createdAt: 1620244715861,
      displayName: 'Михаил Палей',
      email: 'paleyblog@gmail.com',
      id: 'TVwWONM7LVgCI6NnBiT4bIpbRFZ2',
      picture:
          'https://lh3.googleusercontent.com/a-/AOh14GiuH5mkcYoTViolN7kPKBkz8mYE0IaPdBBLQlMv5w=s96-c',
    ),
    User(
      updatedAt: 1620622123039,
      createdAt: 1620622123039,
      displayName: 'Маргарита Емельянова',
      email: 'ritusharira@gmail.com',
      id: 'TAco9JE8NXeooQsVDPsMIHAugpk1',
      picture:
          'https://lh3.googleusercontent.com/a-/AOh14GhX1dOK2WMTNdmjmxnaJUmlcDxrssMwtDNt8aJlcA=s96-c',
    ),
  ];

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

          _friends.removeWhere((friend) => friend.id == viewerState.userId);

          return MainScreen(
            isLoading: isLoading,
            friendsList: _friends,
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
