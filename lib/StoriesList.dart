import 'package:flutter/material.dart';
import 'package:my_wins_today/screens/MainScreen.dart';
import 'package:my_wins_today/screens/sign_in_screen.dart';
import 'package:my_wins_today/widgets/CreateWinForm.dart';
import 'package:my_wins_today/widgets/WinsList.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'screens/CreateWinScreen.dart';
import 'entities/Win.dart';

class StorybookSection {
  static const String Wins = 'Wins';
  static const String Screens = 'Screens';
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
          name: 'CreateWinForm',
          section: StorybookSection.Wins,
          builder: (_, k) => CreateWinForm(
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
            child: child,
            padding: story.padding,
            color: Theme.of(context).canvasColor,
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
