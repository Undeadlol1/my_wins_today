import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/states/viewer_state.dart';

import '../use_cases/create_win.dart';
import '../states/wins_list_state.dart';
import '../use_cases/subscribe_to_wins_stream.dart';

class CreateWinScreenContainer extends StatefulWidget {
  static const path = '/add_win';

  const CreateWinScreenContainer({Key? key}) : super(key: key);

  @override
  _CreateWinScreenState createState() => _CreateWinScreenState();
}

class _CreateWinScreenState extends State<CreateWinScreenContainer> {
  bool _isSubscriptionInitiated = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WinsListState>(
      builder: (winsListState) {
        _subscribeToWinsWhenViewerIsLoaded();

        return CreateWinScreen(
          onSubmit: createWin,
          wins: winsListState.myWins,
        );
      },
    );
  }

  void _subscribeToWinsWhenViewerIsLoaded() {
    if (_shouldViewerSubscribeToHisWins()) {
      log('Subscribing to my wins.');
      Future.microtask(() {
        setState(() => _isSubscriptionInitiated = true);
        subscribeToMyOwnTodaysWins().listen((_) => {});
      });
    }
  }

  bool _shouldViewerSubscribeToHisWins() {
    final viewerState = Get.find<ViewerState>();
    return !_isSubscriptionInitiated &&
        viewerState.hasBeenRequested &&
        !viewerState.isLoading &&
        viewerState.userId != null;
  }
}
