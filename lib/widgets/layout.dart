import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/use_cases/log_out.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';

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
    final viewerState = Get.find<ViewerState>();
    final String viewerPhoto = viewerState.viewer?.photoURL ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: [
          Container(
            width: 35,
            margin: const EdgeInsets.only(right: 15),
            child: viewerPhoto.isEmpty ? null : Image.network(viewerPhoto),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            _loginOrLogoutButton(context),
          ],
        ),
      ),
      body: Padding(
        child: this.widget.body,
        padding: const EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: 0,
        ),
      ),
      floatingActionButton: this.widget.floatingActionButton,
    );
  }

  Widget _loginOrLogoutButton(BuildContext context) {
    final viewerState = Get.find<ViewerState>();
    final bool isViewerSignedIn = viewerState.viewer != null;
    if (viewerState.isLoading) {
      return Container();
    }
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
