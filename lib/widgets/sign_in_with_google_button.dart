import 'package:flutter/material.dart';

class SignInWithGoogleButton extends StatefulWidget {
  const SignInWithGoogleButton({Key? key}) : super(key: key);

  @override
  _SignInWithGoogleButtonState createState() => _SignInWithGoogleButtonState();
}

class _SignInWithGoogleButtonState extends State<SignInWithGoogleButton> {
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
            Text(
              _isDisabled ? 'Подождите...' : 'Войти через Google',
            ),
          ],
        ),
      ),
      onPressed: _isDisabled ? null : () => setState(() => _isDisabled = true),
    );
  }
}
