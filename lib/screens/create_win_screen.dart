import 'package:flutter/material.dart';

import '../entities/win.dart';
import '../widgets/layout.dart';
import '../widgets/create_win_form.dart';

class CreateWinScreen extends StatefulWidget {
  static const path = '/add_win';

  final List<Win> wins;
  final void Function({
    required String title,
    required bool isImportant,
  }) onSubmit;
  const CreateWinScreen({
    Key? key,
    required this.wins,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _CreateWinScreenState createState() => _CreateWinScreenState();
}

class _CreateWinScreenState extends State<CreateWinScreen> {
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
              child: CreateWinForm(
                myWinsToday: widget.wins,
                onSubmit: widget.onSubmit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
