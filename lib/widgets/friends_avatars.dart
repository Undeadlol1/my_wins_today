import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/User.dart';

class FriendsAvatars extends StatelessWidget {
  final List<User> friends;
  FriendsAvatars({Key? key, required this.friends}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: friends.map((e) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              foregroundImage: NetworkImage(e.image),
            ),
          );
        }).toList(),
      ),
    );
  }
}
