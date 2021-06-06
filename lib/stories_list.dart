import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/widgets/create_win_form_story.dart';
import 'package:my_wins_today/widgets/like_button_story.dart';
import 'package:my_wins_today/widgets/users_avatar_list_story.dart';
import 'package:my_wins_today/widgets/wins_list_story.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'entities/user.dart';
import 'entities/Win.dart';
import 'screens/create_win_screen.dart';
import 'screens/main_screen.dart';
import 'screens/sign_in_screen.dart';
import 'widgets/animamted_list_placeholder.dart';
import 'widgets/layout.dart';
import 'widgets/sign_in_with_google_button.dart';

class StorybookSection {
  static const String Wins = 'Wins';
  static const String Users = 'Users';
  static const String Screens = 'Screens';
  static const String Auth = 'Authentication';
  static const String Layout = 'Layout and UI';
}

class StoriesList extends StatefulWidget {
  StoriesList({Key? key}) : super(key: key);

  @override
  _StoriesListState createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList> {
  @override
  void initState() {
    super.initState();
    Get.put(ViewerState());
  }

  @override
  Widget build(BuildContext context) {
    return Storybook(
      children: [
        winsListStory,
        createWinFormStory,
        friendsVatarsStory,
        likeButtonStory,
        Story(
          name: 'MainScreen',
          section: StorybookSection.Screens,
          builder: (_, k) => MainScreen(
            myWinsToday: _wins,
            friendsList: _users,
            isLoading: k.boolean(label: 'Is loading'),
            onCreateWinSubmit:
                ({required bool isImportant, required String title}) => {},
          ),
        ),
        Story(
          name: 'CreateWinScreen',
          section: StorybookSection.Screens,
          builder: (_, k) => CreateWinScreen(
            wins: _wins,
            onSubmit: ({required bool isImportant, required String title}) {},
          ),
        ),
        Story(
          name: 'SignInScreen',
          section: StorybookSection.Screens,
          builder: (_, k) => SignInScreen(),
        ),
        Story(
          section: StorybookSection.Auth,
          name: 'Login with Google button',
          builder: (_, k) => SignInWithGoogleButton(),
        ),
        Story(
          name: 'Layout',
          section: StorybookSection.Layout,
          builder: (_, k) => Layout(
              title: 'Example of a title', body: Text('Example of body')),
        ),
        Story(
          name: 'Animated List',
          section: StorybookSection.Layout,
          builder: (_, k) => AnimatedListPlaceHolder(
            itemCount: k
                .slider(
                  min: 1,
                  max: 20,
                  initial: 5,
                  label: 'Items count',
                )
                .toInt(),
          ),
        ),
      ],
      themeMode: ThemeMode.dark,
      storyWrapperBuilder: (context, story, child) => Stack(
        children: [
          Container(
            padding: story.padding,
            child: Center(child: child),
          ),
        ],
      ),
    );
  }

  final List<User> _users = [
    User(
      id: '321',
      updatedAt: 123,
      createdAt: 123,
      displayName: 'Михаил Палей',
      email: "some@email.com",
      picture: 'https://picsum.photos/200/300',
    ),
    User(
      id: '1232',
      updatedAt: 123,
      createdAt: 123,
      email: "some@email.com",
      displayName: 'Александр Беляев',
      picture: 'https://picsum.photos/200/300',
    ),
  ];

  final List<Win> _wins = [
    Win(
      id: '321',
      userId: '123',
      updatedAt: 123,
      createdAt: 123,
      isImportant: Random().nextBool(),
      title: 'Поздравил Деда',
      likedByUsers: [],
    ),
    Win(
      id: '123',
      userId: '123',
      updatedAt: 123,
      createdAt: 123,
      isImportant: Random().nextBool(),
      title: 'Отправил документы',
      likedByUsers: [],
    ),
  ];
}
