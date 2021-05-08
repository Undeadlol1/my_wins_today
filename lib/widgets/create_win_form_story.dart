import 'dart:math';

import 'package:my_wins_today/entities/Win.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../stories_list.dart';
import 'create_win_form.dart';

final Story createWinFormStory = Story(
  name: 'CreateWinForm',
  section: StorybookSection.Wins,
  builder: (_, k) => CreateWinForm(
    onSubmit: ({required String title, required bool isImportant}) => {},
    myWinsToday: k.options(
      label: 'List values',
      initial: _getLongList(),
      options: [
        Option('Empty', []),
        Option('Long list', _getLongList()),
        Option('Small list', _getSmallList()),
      ],
    ),
  ),
);

List<Win> _getSmallList() {
  return _wins;
}

List<Win> _getLongList() {
  final List<Win> winsList = [];
  for (var i = 0; i < 20; i++) {
    winsList.addAll(_wins);
  }
  return winsList;
}

final List<Win> _wins = [
  Win(
    id: '321',
    userId: '123',
    updatedAt: 123,
    createdAt: 123,
    title: 'Поздравил Деда',
    isImportant: Random().nextBool(),
    likedByUsers: [],
  ),
  Win(
    id: '123',
    userId: '123',
    updatedAt: 123,
    createdAt: 123,
    title: 'Отправил документы',
    isImportant: Random().nextBool(),
    likedByUsers: [],
  ),
];
