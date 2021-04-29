import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';
import 'package:my_wins_today/streams/viewer_stream.dart';
import 'package:my_wins_today/use_cases/log_out.dart';

class Layout extends StatefulWidget {
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
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
      ),
      drawer: Drawer(
        child: _linksList(context),
      ),
      body: Padding(
        child: this.widget.body,
        padding: EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: 0,
        ),
      ),
      floatingActionButton: this.widget.floatingActionButton,
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
