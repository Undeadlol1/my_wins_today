import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/widgets/layout.dart';
import 'package:my_wins_today/widgets/wins_list_container.dart';

class MainScreen extends StatelessWidget {
  static const path = '/';

  final bool isLoading;
  final List<Win> myWinsToday;
  final void Function() onFABPress;

  const MainScreen({
    Key? key,
    this.isLoading = false,
    required this.onFABPress,
    required this.myWinsToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Список побед',
      body: WinsListConntainer(
        wins: this.myWinsToday,
        isLoading: this.isLoading,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: this.onFABPress,
      ),
    );
  }
}
