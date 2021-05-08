import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/User.dart';

class UsersAvatarList extends StatelessWidget {
  final List<User> users;
  UsersAvatarList({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: users.map((user) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            foregroundImage: NetworkImage(user.picture),
          ),
        );
      }).toList(),
    );
  }
}
