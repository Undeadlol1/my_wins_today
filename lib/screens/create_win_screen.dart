import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/DTOs/win_create_dto.dart';
import 'package:my_wins_today/states/wins_list_state.dart';
import 'package:my_wins_today/streams/viewer_stream.dart';
import 'package:my_wins_today/use_cases/create_win.dart';
import 'package:my_wins_today/use_cases/subscribe_to_wins_stream.dart';
import 'package:my_wins_today/widgets/create_win_form.dart';
import 'package:my_wins_today/widgets/layout.dart';

import '../entities/Win.dart';

class CreateWinScreen extends StatelessWidget {
  static const path = '/add_win';

  final List<Win> wins;
  const CreateWinScreen({Key? key, required this.wins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _winsListState = Get.put(WinsListState());
    return StreamBuilder<User?>(
        stream: viewerStream(),
        builder: (context, snapshot) {
          String? userId = snapshot.data?.uid;
          // TODO refactor this whole section.
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('wins').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> _) {
                List<Win> list = [];
                if (_.error != null) {
                  print('Something went wront.');
                  print(_.error);
                }
                if (_.data != null) {
                  print('is data empty: ' + _.data!.docs.isEmpty.toString());
                  print(
                      'Items in data array: ' + _.data!.docs.length.toString());
                  // _.data!.docs.toList().forEach(
                  //       (e) => print(e.data().toString()),
                  //     );

                  _.data!.docs.toList().forEach((element) {
                    var data = element.data();
                    list.add(Win(
                      id: data['id'],
                      userId: data['userId'],
                      title: data['title'],
                      createdAt: data['createdAt'],
                      updatedAt: data['updatedAt'],
                    ));
                  });

                  list.sort((first, second) =>
                      first.createdAt.compareTo(second.createdAt));
                }
                print('snapshot ' + _.data.toString());
                return Layout(
                  title: 'Добавьте победу',
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: GetBuilder<WinsListState>(
                            builder: (winsState) {
                              return CreateWinForm(
                                // myWinsToday: _winsListState.wins,
                                myWinsToday: list,
                                onSubmit: ({String title = ''}) {
                                  if (userId != null) {
                                    createWin(WinCreateDTO(
                                      title: title,
                                      userId: userId,
                                    ));
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
