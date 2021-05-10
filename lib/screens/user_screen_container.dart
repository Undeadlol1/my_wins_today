import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/screens/user_screen.dart';
import 'package:my_wins_today/states/user_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';
import 'package:my_wins_today/use_cases/get_user.dart';
import 'package:my_wins_today/use_cases/subscribe_to_friends_todays_wins.dart';

class UserScreenContainer extends StatefulWidget {
  const UserScreenContainer({Key? key}) : super(key: key);

  @override
  _UserScreenContainerState createState() => _UserScreenContainerState();
}

class _UserScreenContainerState extends State<UserScreenContainer> {
  @override
  void initState() {
    super.initState();

    final String? userId = Get.parameters['userId'];
    Get.put(UserState());
    getUser(userId!);
    Future.microtask(() => subscribeToFriendsTodaysWins().listen((_) {}));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserState>(
      builder: (userState) => GetBuilder<WinsListState>(
        builder: (winsListState) {
          return UserScreen(
            user: userState.data,
            winsToday: winsListState.friendsWins,
            isLoading: userState.isLoading || winsListState.isLoading,
          );
        },
      ),
    );
  }
}
