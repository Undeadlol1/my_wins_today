import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/user.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/widgets/create_win_form.dart';
import 'package:my_wins_today/widgets/layout.dart';
import 'package:my_wins_today/widgets/users_avatar_list.dart';

class MainScreen extends StatelessWidget {
  static const path = '/';

  final bool isLoading;
  final List<Win> myWinsToday;
  final List<User> friendsList;
  final void Function({
    required bool isImportant,
    required String title,
  }) onCreateWinSubmit;

  const MainScreen({
    Key? key,
    this.isLoading = false,
    required this.myWinsToday,
    required this.friendsList,
    required this.onCreateWinSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Ваши победы',
      body: Column(
        children: [
          UsersAvatarList(users: friendsList),
          CreateWinForm(
            myWinsToday: myWinsToday,
            onSubmit: onCreateWinSubmit,
          ),
        ],
      ),
    );
  }
}
