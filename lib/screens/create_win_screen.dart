import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/Win.dart';
import '../widgets/layout.dart';
import '../DTOs/win_create_dto.dart';
import '../use_cases/create_win.dart';
import '../streams/viewer_stream.dart';
import '../states/wins_list_state.dart';
import '../widgets/create_win_form.dart';
import '../use_cases/subscribe_to_wins_stream.dart';

class CreateWinScreen extends StatelessWidget {
  static const path = '/add_win';

  final List<Win> wins;
  const CreateWinScreen({Key? key, required this.wins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: viewerStream(),
      builder: (context, authSnapshot) {
        String? userId = authSnapshot.data?.uid;
        return StreamBuilder<List<Win>>(
          initialData: [],
          stream: subscribeToWinsStream(),
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
                        myWinsToday: winsSnapshot.data!.toList(),
                        onSubmit: ({String title = ''}) => _onSubmit(
                          title: title,
                          userId: userId == null ? '' : userId,
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
