import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';

class WinsList extends StatelessWidget {
  final List<Win> wins;
  const WinsList({Key? key, required this.wins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.wins.length,
      itemBuilder: (BuildContext context, int index) {
        return Text((index + 1).toString() + ') ' + wins[index].title);
      },
    );
  }
}
