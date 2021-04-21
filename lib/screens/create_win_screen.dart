import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/DTOs/win_create_dto.dart';
import 'package:my_wins_today/streams/viewer_stream.dart';
import 'package:my_wins_today/use_cases/create_win.dart';
import 'package:my_wins_today/widgets/layout.dart';
import 'package:my_wins_today/widgets/create_win_form.dart';

import '../entities/Win.dart';

class CreateWinScreen extends StatelessWidget {
  static const path = '/add_win';

  final List<Win> wins;
  const CreateWinScreen({Key? key, required this.wins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: viewerStream(),
        builder: (context, snapshot) {
          String? userId = snapshot.data?.uid;
          return Layout(
            title: 'Добавьте победу',
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(
                    child: CreateWinForm(
                      myWinsToday: this.wins,
                      onSubmit: ({String title = ''}) {
                        print('title ' + title);
                        if (userId != null) {
                          createWin(WinCreateDTO(
                            title: title,
                            userId: userId,
                          ));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
