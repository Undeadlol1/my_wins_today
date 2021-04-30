import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/states/viewer_state.dart';

import '../states/wins_list_state.dart';
import '../use_cases/create_win.dart';
import '../use_cases/subscribe_to_wins_stream.dart';

class CreateWinScreenContainer extends StatefulWidget {
  static const path = '/add_win';

  const CreateWinScreenContainer({Key? key}) : super(key: key);

  @override
  _CreateWinScreenState createState() => _CreateWinScreenState();
}

class _CreateWinScreenState extends State<CreateWinScreenContainer> {
  bool _isSubscrbeFunctionInitiated = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewerState>(
      builder: (viewerState) {
        final winsListState = Get.find<WinsListState>();

        if (_shouldVidwerSubscribeToHisWins(viewerState)) {
          log('About to subscribe to my wins.');
          Future.microtask(() {
            setState(() => _isSubscrbeFunctionInitiated = true);
            subscribeToMyOwnTodaysWins().listen((_) => {});
          });
        }

        return CreateWinScreen(
          onSubmit: createWin,
          wins: winsListState.myWins,
        );
      },
    );
  }

  bool _shouldVidwerSubscribeToHisWins(ViewerState viewerState) {
    return !_isSubscrbeFunctionInitiated &&
        viewerState.hasBeenRequested &&
        !viewerState.isLoading &&
        viewerState.userId != null;
  }
}
