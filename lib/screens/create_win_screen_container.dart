import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DTOs/win_create_dto.dart';
import '../entities/Win.dart';
import '../states/wins_list_state.dart';
import '../streams/viewer_stream.dart';
import '../use_cases/create_win.dart';
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
        String userId = authSnapshot.data?.uid ?? '';
        final winsListState = Get.put(WinsListState());
        return StreamBuilder<List<Win>>(
            initialData: [],
            stream: subscribeToTodaysWinsStream(userId: userId),
            builder:
                (BuildContext context, AsyncSnapshot<List<Win>> winsSnapshot) =>
                    CreateWinScreen(
                      wins: winsListState.myWins,
                    ));
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
