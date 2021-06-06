import 'dart:math';

import 'package:my_wins_today/entities/win.dart';
import 'package:my_wins_today/widgets/wins_list.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../stories_list.dart';

final Story winsListStory = Story(
  name: 'WinsList',
  section: StorybookSection.Wins,
  builder: (_, k) => WinsList(
    wins: k.options(
      label: 'List values',
      initial: _wins,
      options: [
        Option('Empty', []),
        Option('Small list', _getSmallList()),
        Option('Long list', _getLongList()),
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
    isReversed: k.options(
      label: 'Is list reversed',
      initial: false,
      options: [
        Option('True', true),
        Option('False', false),
      ],
    ),
    viewerId: k.options(
      label: 'Are this viewer\'s wins?',
      initial: '',
      options: [
        Option('Yes', ''),
        Option('No', _viewerId),
      ],
    ),
  ),
);

const _viewerId = '123';

List<Win> _getSmallList() {
  return _wins;
}

List<Win> _getLongList() {
  final List<Win> winsList = [];
  for (var i = 0; i < 10; i++) {
    winsList.addAll(_wins);
  }
  return winsList;
}

final List<Win> _wins = [
  Win(
    id: '321',
    userId: _viewerId,
    updatedAt: 123,
    createdAt: 123,
    isImportant: true,
    title: 'Поздравил Деда',
    likedByUsers: [],
  ),
  Win(
    id: '123',
    userId: _viewerId,
    updatedAt: 123,
    createdAt: 123,
    isImportant: false,
    title: 'Отправил документы',
    likedByUsers: [],
  ),
  Win(
    id: '123',
    userId: _viewerId,
    updatedAt: 123,
    createdAt: 123,
    title:
        'This is a very long text. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    isImportant: Random().nextBool(),
    likedByUsers: [],
  ),
];
