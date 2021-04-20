import 'package:flutter/material.dart';
import 'package:my_wins_today/widgets/layout.dart';
import 'package:my_wins_today/widgets/sign_in_with_google_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Войти',
      body: Center(
        child: SignInWithGoogleButton(),
      ),
    );
  }
}
