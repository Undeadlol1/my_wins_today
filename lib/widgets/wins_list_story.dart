import 'package:my_wins_today/entities/Win.dart';
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
  ),
);

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
