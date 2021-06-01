import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';

import 'animamted_list_placeholder.dart';
import 'like_button.dart';

final winsListGlobalKey = GlobalKey<AnimatedListState>();

class WinsList extends StatelessWidget {
  final List<Win> wins;
  final bool isLoading;
  final bool isReversed;
  final String viewerId;
  final Future Function({
    required Win winToUpdate,
  })? onLikeButtonTap;

  const WinsList({
    Key? key,
    required this.wins,
    this.viewerId = '',
    this.onLikeButtonTap,
    this.isLoading = false,
    this.isReversed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('isLoading: ${isLoading}');
    if (isLoading) {
      return AnimatedListPlaceHolder();
    }

    if (wins.isEmpty) {
      return _emptyStateWidget();
    }

    return AnimatedList(
      primary: false,
      shrinkWrap: true,
      key: winsListGlobalKey,
      itemBuilder: _buildListItem,
      initialItemCount: wins.length,
    );
  }

  Widget _emptyStateWidget() {
    return Center(
      child: Text(
        'Список побед пуст',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    final win = isReversed ? wins.reversed.toList()[index] : wins[index];
    final String textPrefix = (wins.indexOf(win) + 1).toString() + ') ';

    final normalTextStyle = Theme.of(context).textTheme.headline6;
    final importantTextStyle = normalTextStyle!.merge(
      TextStyle(color: Theme.of(context).buttonColor),
    );

    final isWinLikedByMe = win.likedByUsers.contains(viewerId);
    final isMyOwnWinsList = wins.every((element) => element.userId == viewerId);

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(textPrefix, style: normalTextStyle),
          Expanded(
            child: Text(
              win.title,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: win.isImportant ? importantTextStyle : normalTextStyle,
            ),
          ),
          LikeButton(
            isDisabled: isMyOwnWinsList,
            onTap: () async => onLikeButtonTap!(winToUpdate: win),
            isLiked:
                isMyOwnWinsList ? win.likedByUsers.isNotEmpty : isWinLikedByMe,
          ),
        ],
      ),
    );
  }
}
