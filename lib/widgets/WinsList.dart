import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';

class WinsList extends StatelessWidget {
  final List<Win> wins;
  const WinsList({Key? key, required this.wins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (wins.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: EmptyListWidget(
          image: null,
          packageImage: PackageImage.Image_1,
          title: 'No Notification',
          subTitle: 'No  notification available yet',
          titleTextStyle: TextStyle(
            fontSize: 22,
            color: Color(0xff9da9c7),
            fontWeight: FontWeight.w500,
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 14,
            color: Color(0xffabb8d6),
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: this.wins.length,
      itemBuilder: (BuildContext context, int index) {
        return Text((index + 1).toString() + ') ' + wins[index].title);
      },
    );
  }
}
