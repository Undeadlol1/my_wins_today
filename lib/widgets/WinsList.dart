import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';

class WinsList extends StatelessWidget {
  final List<Win> items;
  const WinsList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.items.isEmpty) {
      return Container();
    }

    return Container(
      child: ListView.builder(
        itemCount: this.items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = this.items[index];
          return ListTile(
            title: Text(item.title),
          );
        },
      ),
    );
  }
}
