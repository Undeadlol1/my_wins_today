import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/user.dart';
import 'package:my_wins_today/screens/user_screen.dart';

class UsersAvatarList extends StatelessWidget {
  final List<User> users;
  UsersAvatarList({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: users.map((user) {
        return InkWell(
          onTap: () => Get.toNamed(UserScreen.path + user.id),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              foregroundImage: NetworkImage(user.picture),
            ),
          ),
        );
      }).toList(),
    );
  }
}
