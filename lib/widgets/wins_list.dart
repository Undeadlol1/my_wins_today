import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';

import 'animamted_list_placeholder.dart';

class WinsList extends StatelessWidget {
  final List<Win> wins;
  final bool isLoading;
  final bool isReversed;
  const WinsList({
    Key? key,
    required this.wins,
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
      itemCount: this.wins.length,
      itemBuilder: (BuildContext context, int index) {
        final win = isReversed ? wins.reversed.toList()[index] : wins[index];

        return _buildListItem(
          win: win,
          context: context,
        );
      },
    );
  }

  Widget _buildListItem({required Win win, required BuildContext context}) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.headline6;
    final String textPrefix = (wins.indexOf(win) + 1).toString() + ') ';

    return Expanded(
      child: Row(
        children: [
          Text(textPrefix, style: textStyle),
          // NOTE: currently some wins do not have "isImportant" property. (28.04.2021)
          // remove this check in the future when all wins are going to have the property.
          // ignore: unnecessary_null_comparison
          if (win.isImportant != null && win.isImportant)
            Icon(
              Icons.star,
              color: theme.primaryColor,
            ),
          Text(
            win.title,
            maxLines: 3,
            softWrap: true,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

Widget _emptyStateWidget() {
  return Center(
    child: Text(
      'Список побед пуст',
      style: TextStyle(fontStyle: FontStyle.italic),
    ),
  );
}
