import 'package:my_wins_today/widgets/friends_avatars.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../stories_list.dart';
import '../entities/User.dart';

final Story friendsVatarsStory = Story(
  name: 'Friends Avatars',
  section: StorybookSection.Users,
  builder: (_, k) => FriendsAvatars(
    friends: k.options(
      label: 'List values',
      initial: _getSmallList(),
      options: [
        Option('Empty', []),
        Option('Long list', _getLongList()),
        Option('Small list', _getSmallList()),
      ],
    ),
  ),
);

List<User> _getSmallList() {
  return _users;
}

List<User> _getLongList() {
  final List<User> winsList = [];
  for (var i = 0; i < 10; i++) {
    winsList.addAll(_users);
  }
  return winsList;
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
