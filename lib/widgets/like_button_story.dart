import 'package:my_wins_today/widgets/like_button.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../stories_list.dart';

final Story likeButtonStory = Story(
  name: 'LikeButton',
  section: StorybookSection.Users,
  builder: (_, k) => LikeButton(
    isLiked: k.options(
      label: 'Is liked',
      initial: false,
      options: [
        Option('Yes', true),
        Option('No', false),
      ],
    ),
    isDisabled: k.options(
      label: 'Is disabled',
      initial: false,
      options: [
        Option('Yes', true),
        Option('No', false),
      ],
    ),
    onTap: () async => {},
  ),
);
