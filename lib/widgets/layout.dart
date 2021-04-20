import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';
import 'package:my_wins_today/streams/viewer_stream.dart';
import 'package:my_wins_today/use_cases/log_out.dart';

class Layout extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  const Layout({
    Key? key,
    required this.title,
    required this.body,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      drawer: Drawer(
        child: _linksList(context),
      ),
      body: Padding(
        child: this.body,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
      ),
      floatingActionButton: this.floatingActionButton,
    );
  }

  Widget _linksList(BuildContext context) {
    return StreamBuilder<User?>(
      stream: viewerStream(),
      builder: (context, snapshot) {
        final bool isViewerSignedIn = snapshot.data != null;
        final bool isAuthLoaded =
            snapshot.connectionState == ConnectionState.active;
        return ListView(
          children: [
            if (isAuthLoaded) _loginOrLogoutButton(context, isViewerSignedIn)
          ],
        );
      },
    );
  }

  Widget _loginOrLogoutButton(BuildContext context, bool isViewerSignedIn) {
    return ListTile(
      title: TextButton(
        onPressed: () {},
        child: ListTile(
          onTap: () async {
            isViewerSignedIn
                ? await logOut()
                : Navigator.pushNamed(
                    context,
                    SignInScreen.path,
                  );
          },
          title: Text(
            isViewerSignedIn ? 'Выйти' : 'Войти',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
