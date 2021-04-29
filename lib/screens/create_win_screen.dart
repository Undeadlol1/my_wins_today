import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/states/viewer_state.dart';

import '../entities/Win.dart';
import '../widgets/layout.dart';
import '../DTOs/win_create_dto.dart';
import '../use_cases/create_win.dart';
import '../states/wins_list_state.dart';
import '../widgets/create_win_form.dart';
import '../use_cases/subscribe_to_wins_stream.dart';

class CreateWinScreen extends StatefulWidget {
  static const path = '/add_win';

  final List<Win> wins;
  const CreateWinScreen({Key? key, required this.wins}) : super(key: key);

  @override
  _CreateWinScreenState createState() => _CreateWinScreenState();
}

class _CreateWinScreenState extends State<CreateWinScreen> {
  bool _isSubscrbeFunctionInitiated = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewerState>(
      builder: (viewerState) {
        String userId = viewerState.userId ?? '';
        final winsListState = Get.find<WinsListState>();

        if (_shouldVidwerSubscribeToHisWins(viewerState)) {
          log('About to subscribe to my wins.');
          Future.microtask(() {
            setState(() => _isSubscrbeFunctionInitiated = true);
            subscribeToMyOwnTodaysWins().listen((_) => {});
          });
        }

        return Layout(
          title: 'Добавьте победу',
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: GetBuilder<WinsListState>(
                    init: WinsListState(),
                    builder: (winsState) => CreateWinForm(
                      myWinsToday: winsListState.myWins,
                      // TODO refactor this.
                      onSubmit: (
                              {String title = '', bool isImportant = false}) =>
                          _onSubmit(
                        title: title,
                        userId: userId,
                        isImportant: isImportant,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSubmit({
    String title = '',
    String userId = '',
    bool isImportant = false,
  }) {
    // TODO: pick userId inside a use_case.
    if (userId.isNotEmpty) {
      createWin(WinCreateDTO(
        title: title,
        userId: userId,
        isImportant: isImportant,
      ));
    }
  }

  bool _shouldVidwerSubscribeToHisWins(ViewerState viewerState) {
    return !_isSubscrbeFunctionInitiated &&
        viewerState.hasBeenRequested &&
        !viewerState.isLoading &&
        viewerState.userId != null;
  }
}
