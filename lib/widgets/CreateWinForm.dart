import 'package:flutter/material.dart';

class CreateWinForm extends StatefulWidget {
  CreateWinForm({Key key}) : super(key: key);

  @override
  _CreateWinFormState createState() => _CreateWinFormState();
}

class _CreateWinFormState extends State<CreateWinForm> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: _textValidator,
            decoration: InputDecoration(
              labelText: 'Введите название победы',
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Text('Сохранить'),
              onPressed: _displaySnackbar,
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
        ],
      ),
    );
  }

  void _displaySnackbar() {
    if (_form.currentState.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Шота делоим')));
    }
  }

  String _textValidator(String value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите текст';
    }
    return null;
  }
}
