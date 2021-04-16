import 'package:flutter/material.dart';
import 'package:my_wins_today/widgets/WinsList.dart';

import '../entities/Win.dart';

class CreateWinScreen extends StatelessWidget {
  final List<Win> wins;
  const CreateWinScreen({Key key, @required this.wins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Center(child: WinsList(items: this.wins)),
        ),
      ],
    );
  }
}
