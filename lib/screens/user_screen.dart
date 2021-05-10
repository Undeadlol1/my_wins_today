import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/widgets/layout.dart';
import 'package:my_wins_today/widgets/wins_list_container.dart';

class UserScreen extends StatelessWidget {
  static const path = '/user/';

  final String userId;
  final bool isLoading;
  final List<Win> winsToday;

  const UserScreen({
    Key? key,
    this.isLoading = false,
    required this.winsToday,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Страница пользователя',
      body: Column(
        children: [
          Text('User id is: $userId'),
          WinsListContainer(
            wins: this.winsToday,
            isLoading: this.isLoading,
          ),
        ],
      ),
    );
  }
}
