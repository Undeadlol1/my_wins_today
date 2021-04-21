import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'entities/Win.dart';
import 'widgets/layout.dart';
import 'widgets/wins_list.dart';
import 'screens/main_screen.dart';
import 'widgets/create_win_form.dart';
import 'screens/sign_in_screen.dart';
import 'screens/create_win_screen.dart';
import 'widgets/sign_in_with_google_button.dart';
import 'widgets/animamted_list_placeholder.dart';

class StorybookSection {
  static const String Wins = 'Wins';
  static const String Screens = 'Screens';
  static const String Auth = 'Authentication';
  static const String Layout = 'Layout and UI';
}

class StoriesList extends StatelessWidget {
  StoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Storybook(
      children: [
        Story(
          name: 'MainScreen',
          section: StorybookSection.Screens,
          builder: (_, k) => MainScreen(myWinsToday: _wins),
        ),
        Story(
          name: 'CreateWinScreen',
          section: StorybookSection.Screens,
          builder: (_, k) => CreateWinScreen(wins: _wins),
        ),
        Story(
          name: 'SignInScreen',
          section: StorybookSection.Screens,
          builder: (_, k) => SignInScreen(),
        ),
        Story(
          name: 'Login with Google button',
          section: StorybookSection.Auth,
          builder: (_, k) => SignInWithGoogleButton(),
        ),
        Story(
          name: 'WinsList',
          section: StorybookSection.Wins,
          builder: (_, k) => WinsList(
            wins: k.options(
              label: 'List values',
              initial: _wins,
              options: [
                Option('Empty', []),
                Option('With data', _wins),
              ],
            ),
            isLoading: k.options(
              label: 'Is loading',
              initial: false,
              options: [
                Option('True', true),
                Option('False', false),
              ],
            ),
          ),
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
        Story(
          name: 'CreateWinForm',
          section: StorybookSection.Wins,
          builder: (_, k) => CreateWinForm(
            onSubmit: ({String title = ''}) => {},
            myWinsToday: k.options(
              label: 'List values',
              initial: _wins,
              options: [
                Option('Empty', []),
                Option('With data', _wins),
              ],
            ),
          ),
        ),
      ],
      storyWrapperBuilder: (context, story, child) => Stack(
        children: [
          Container(
            color: Colors.black54,
            padding: story.padding,
            child: Center(child: child),
          ),
        ],
      ),
    );
  }

  final List<Win> _wins = [
    Win(
      id: '321',
      userId: '123',
      updatedAt: 123,
      createdAt: 123,
      title: 'Поздравил Деда',
    ),
    Win(
      id: '123',
      userId: '123',
      updatedAt: 123,
      createdAt: 123,
      title: 'Отправил документы',
    ),
  ];
}
