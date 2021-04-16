import 'package:flutter/material.dart';
import 'package:my_wins_today/screens/MainScreen.dart';
import 'package:my_wins_today/widgets/CreateWinForm.dart';
import 'package:my_wins_today/widgets/WinsList.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'screens/CreateWinScreen.dart';
import 'entities/Win.dart';

class StoriesList extends StatelessWidget {
  StoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Storybook(
      children: [
        Story.simple(
          name: 'MainScreen',
          child: MainScreen(myWinsToday: _wins),
        ),
        Story.simple(
          name: 'CreateWinScreen',
          child: CreateWinScreen(wins: _wins),
        ),
        Story(
          section: 'Wins',
          name: 'CreateWinForm',
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
        Story.simple(name: 'WinsList', child: WinsList(items: _wins)),
      ],
      storyWrapperBuilder: (context, story, child) => Stack(
        children: [
          Container(
            padding: story.padding,
            child: Center(child: child),
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
