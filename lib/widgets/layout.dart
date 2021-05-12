import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/screens/main_screen.dart';
import 'package:my_wins_today/use_cases/log_out.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';

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
        actions: [_buildUserAvatar()],
      ),
      drawer: Drawer(
        child: ListView(
          children: [_loginOrLogoutButton()],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: this.body,
          padding: const EdgeInsets.only(
            top: 20,
            left: 15,
            right: 15,
            bottom: 0,
          ),
        ),
      ),
      floatingActionButton: this.floatingActionButton,
    );
  }

  Widget _buildUserAvatar() {
    final viewerState = Get.find<ViewerState>();
    final String viewerPhoto = viewerState.viewer?.picture ?? '';

    return Container(
      width: 35,
      margin: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () => Get.toNamed(MainScreen.path),
        child: viewerPhoto.isEmpty ? null : Image.network(viewerPhoto),
      ),
    );
  }

  Widget _loginOrLogoutButton() {
    final viewerState = Get.find<ViewerState>();

    if (viewerState.isLoading) {
      return Container();
    }

    final bool isViewerSignedIn = viewerState.viewer != null;
    return ListTile(
      onTap: isViewerSignedIn ? logOut : () => Get.toNamed(SignInScreen.path),
      title: Text(
        isViewerSignedIn ? 'Выйти' : 'Войти',
        textAlign: TextAlign.center,
      ),
    );
  }
}
