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

class CreateWinScreen extends StatelessWidget {
  static const path = '/add_win';

  final List<Win> wins;
  const CreateWinScreen({Key? key, required this.wins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewerState>(
      builder: (viewerState) {
        String userId = viewerState.userId ?? '';
        final winsListState = Get.find<WinsListState>();
        return StreamBuilder<List<Win>>(
          initialData: [],
          stream: subscribeToMyOwnTodaysWins(userId: userId),
          builder:
              (BuildContext context, AsyncSnapshot<List<Win>> winsSnapshot) =>
                  Layout(
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
                        onSubmit: ({String title = ''}) => _onSubmit(
                          title: title,
                          userId: userId,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSubmit({String title = '', String userId = ''}) {
    if (userId.isNotEmpty) {
      createWin(WinCreateDTO(
        title: title,
        userId: userId,
      ));
    }
  }
}
