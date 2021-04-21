import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/widgets/wins_list.dart';

String _titleInputText = '';

class CreateWinForm extends StatefulWidget {
  final List<Win> myWinsToday;
  final void Function({String title}) onSubmit;
  const CreateWinForm({
    Key? key,
    required this.onSubmit,
    required this.myWinsToday,
  }) : super(key: key);

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
          Flexible(
            child: WinsList(wins: widget.myWinsToday),
          ),
          Flexible(
            child: Row(
              children: [
                _numberOfWinsText(),
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    validator: _textValidator,
                    onChanged: (value) => _titleInputText = value,
                    decoration: InputDecoration(
                      labelText: 'Введите название победы',
                    ),
                    onEditingComplete: _displaySnackbar,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              child: ElevatedButton(
                child: Text('Сохранить'),
                onPressed: _displaySnackbar,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Text _numberOfWinsText() =>
      Text((widget.myWinsToday.length + 1).toString() + ') ');

  void _displaySnackbar() {
    if (_form.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Введенный текст: ' + _titleInputText),
        ),
      );
      widget.onSubmit(title: _titleInputText);
      print('_titleInputText: ' + _titleInputText);
      // _resetForm();
    }
  }

  String? _textValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите текст';
    }
    return null;
  }

  // void _resetForm() {
  //   _titleInputText = '';
  //   _form.currentState?.reset();
  // }
}
