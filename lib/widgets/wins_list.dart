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
    if (this.wins.isEmpty) {
      return _emptyStateWidget();
    }

    return ListView.builder(
      itemCount: this.wins.length,
      itemBuilder: (BuildContext context, int index) {
        final win = isReversed ? wins.reversed.toList()[index] : wins[index];
        String textPrefix = (wins.indexOf(win) + 1).toString() + ') ';

        return Text(
          textPrefix + win.title,
          style: Theme.of(context).textTheme.headline6,
        );
      },
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
