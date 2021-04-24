import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';

import 'animamted_list_placeholder.dart';

class WinsList extends StatelessWidget {
  final List<Win> wins;
  final bool isLoading;
  const WinsList({
    Key? key,
    required this.wins,
    this.isLoading = false,
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
        return Text(
          (index + 1).toString() + ') ' + wins[index].title,
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
