import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/widgets/wins_list_container.dart';

String _titleInputText = '';

class CreateWinForm extends StatefulWidget {
  final List<Win> myWinsToday;
  final void Function({
    required String title,
    required bool isImportant,
  }) onSubmit;
  const CreateWinForm({
    Key? key,
    required this.onSubmit,
    required this.myWinsToday,
  }) : super(key: key);

  @override
  _CreateWinFormState createState() => _CreateWinFormState();
}

class _CreateWinFormState extends State<CreateWinForm> {
  bool _checkboxValue = false;
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildInputForm(),
          _buildCheckbox(),
          _buildSubmitButton(),
          WinsListContainer(
            isLoading: false,
            isReversed: true,
            wins: widget.myWinsToday,
          ),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    final viewerState = Get.find<ViewerState>();
    return Row(
      children: [
        _numberOfWinsPrefix(),
        Expanded(
          child: TextFormField(
            validator: _validateText,
            decoration: InputDecoration(
              labelText: 'Введите название победы',
            ),
            onTap: () {
              if (viewerState.viewer == null) {
                Navigator.of(context).pushNamed(SignInScreen.path);
              }
            },
            onEditingComplete: _saveAndResetForm,
            onChanged: (value) => _titleInputText = value,
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox() {
    return CheckboxListTile(
      value: _checkboxValue,
      title: Text('Это очень важно'),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (newValue) {
        log('Checkbox new value: ' + newValue.toString());
        setState(() => _checkboxValue = newValue!);
      },
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      child: ElevatedButton(
        child: Text('Сохранить'),
        onPressed: _saveAndResetForm,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
    );
  }

  void _saveAndResetForm() {
    if (_form.currentState!.validate()) {
      widget.onSubmit(
        title: _titleInputText.trim(),
        isImportant: _checkboxValue,
      );
      _resetForm();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Сохранено.'),
        ),
      );
    }
  }

  String? _validateText(String? value) {
    String trimmedText = value!.trim();
    if (trimmedText.isEmpty) {
      return 'Введите текст';
    }
    if (trimmedText.length < 5) {
      return 'Слишком коротко';
    }
    return null;
  }

  void _resetForm() {
    _titleInputText = '';
    _form.currentState?.reset();
    setState(() => _checkboxValue = false);
  }

  Text _numberOfWinsPrefix() =>
      Text((widget.myWinsToday.length + 1).toString() + ') ');
}
