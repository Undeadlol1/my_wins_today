import 'package:flutter/material.dart';

class CreateWinForm extends StatefulWidget {
  CreateWinForm({Key key}) : super(key: key);

  @override
  _CreateWinFormState createState() => _CreateWinFormState();
}

class _CreateWinFormState extends State<CreateWinForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Center(child: Text('A form to create a win')),
        Spacer(),
        Placeholder()
      ],
    );
  }
}
