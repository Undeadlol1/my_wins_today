import 'package:flutter/material.dart';
import 'package:my_wins_today/widgets/CreateWinForm.dart';
import 'package:my_wins_today/widgets/layout.dart';

import '../entities/Win.dart';

class CreateWinScreen extends StatelessWidget {
  final List<Win> wins;
  const CreateWinScreen({Key? key, required this.wins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Добавьте победу',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: CreateWinForm(myWinsToday: this.wins),
            ),
          ),
        ],
      ),
    );
  }
}
