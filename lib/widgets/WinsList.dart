import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';

class WinsList extends StatelessWidget {
  final List<Win> items;
  const WinsList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container();
    }

    return ListView.builder(
      itemCount: this.items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(items[index].title),
          leading: Text((index + 1).toString() + ') '),
        );
      },
    );
  }
}
