import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'animamted_list_placeholder.dart';

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
    if (isLoading) {
      return AnimatedListPlaceHolder();
    }

    if (wins.isEmpty) {
      return _emptyStateWidget();
    }

    return ListView.builder(
      itemCount: wins.length,
      itemBuilder: (BuildContext context, int index) {
        final win = isReversed ? wins.reversed.toList()[index] : wins[index];

        return _buildListItem(
          win: win,
          context: context,
        );
      },
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

  Widget _buildListItem({required Win win, required BuildContext context}) {
    final theme = Theme.of(context);
    final normalTextStyle = theme.textTheme.headline6;
    final importantTextStyle = normalTextStyle!.merge(
      TextStyle(color: theme.accentColor),
    );

    final String textPrefix = (wins.indexOf(win) + 1).toString() + ') ';

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
          _buildLikeButton(win),
        ],
      ),
    );
  }

  Widget _buildLikeButton(Win win) {
    bool isWinLiked = win.likedByUsers.contains(viewerId);

    return TapDebouncer(
      cooldown: const Duration(milliseconds: 1500),
      onTap: onLikeButtonTap == null
          ? null
          : () async => await onLikeButtonTap!(winToUpdate: win),
      builder: (BuildContext context, TapDebouncerFunc? onTap) {
        return InkWell(
          child: Container(
            padding: EdgeInsets.all(2.5),
            child: Icon(
              isWinLiked ? Icons.favorite : Icons.favorite_outline,
            ),
          ),
          onTap: onTap,
        );
      },
    );
  }
}
