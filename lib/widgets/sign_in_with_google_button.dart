import 'package:flutter/material.dart';
import 'package:my_wins_today/use_cases/sign_in_with_google.dart';

class SignInWithGoogleButton extends StatefulWidget {
  const SignInWithGoogleButton({Key? key}) : super(key: key);

  @override
  _SignInWithGoogleButtonState createState() => _SignInWithGoogleButtonState();
}

class _SignInWithGoogleButtonState extends State<SignInWithGoogleButton> {
  String _errorText = '';
  bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login),
            SizedBox(width: 20),
            Text(_getButtonText()),
          ],
        ),
      ),
      onPressed: _signInAndHandleErrors,
    );
  }

  _signInAndHandleErrors() async {
    if (_isDisabled) return null;
    setState(() => _isDisabled = true);
    try {
      await signInWithGoogle();
    } on Exception catch (error) {
      print('Something went wrong during google sign in.');
      print(error);
      setState(() => _errorText = 'Произошла ошибка');
    }
  }

  String _getButtonText() {
    if (_errorText.isNotEmpty) {
      return _errorText;
    }
    return _isDisabled ? 'Подождите...' : 'Войти через Google';
  }
}
