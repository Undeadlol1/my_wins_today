import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/user.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/widgets/layout.dart';
import 'package:my_wins_today/widgets/wins_list_container.dart';

class UserScreen extends StatelessWidget {
  static const path = '/user/';

  final User? user;
  final bool isLoading;
  final List<Win> winsToday;

  const UserScreen({
    Key? key,
    this.isLoading = false,
    required this.user,
    required this.winsToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Страница пользователя',
      body: Column(
        children: [
          _buildUserNameAndAvatar(),
          SizedBox(height: 20),
          WinsListContainer(
            wins: this.winsToday,
            isLoading: this.isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildUserNameAndAvatar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(user?.displayName ?? ''),
        if (user != null)
          CircleAvatar(
            foregroundImage: NetworkImage(user!.picture),
          ),
      ],
    );
  }
}
