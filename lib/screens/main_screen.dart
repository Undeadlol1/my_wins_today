import 'package:flutter/material.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/widgets/layout.dart';
import 'package:my_wins_today/widgets/wins_list.dart';

class MainScreen extends StatelessWidget {
  static const path = '/';

  final List<Win> myWinsToday;
  final bool isLoading;
  final void Function() onFABPress;

  const MainScreen({
    Key? key,
    required this.myWinsToday,
    required this.onFABPress,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'Список побед',
      body: WinsList(
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
