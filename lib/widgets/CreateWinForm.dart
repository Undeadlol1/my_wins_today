import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/widgets/WinsList.dart';

class CreateWinForm extends StatefulWidget {
  final List<Win> myWinsToday;
  const CreateWinForm({
    Key? key,
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
                _numberOfWins(),
                Expanded(
                  child: TextFormField(
                    validator: _textValidator,
                    decoration: InputDecoration(
                      labelText: 'Введите название победы',
                    ),
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

  Text _numberOfWins() =>
      Text((widget.myWinsToday.length + 1).toString() + ') ');

  void _displaySnackbar() {
    if (_form.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Шота делоим'),
        ),
      );
    }
  }

  String _textValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите текст';
    }
    return '';
  }
}
