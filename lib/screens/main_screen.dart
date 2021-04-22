import 'package:flutter/material.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/use_cases/subscribe_to_wins_stream.dart';

import '../entities/Win.dart';
import '../widgets/layout.dart';
import '../widgets/wins_list.dart';

class MainScreen extends StatelessWidget {
  static const path = '/';

  final List<Win> myWinsToday;
  const MainScreen({Key? key, required this.myWinsToday}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Win>>(
        initialData: [],
        stream: subscribeToWinsStream(),
        builder: (_, AsyncSnapshot<List<Win>> snapshot) {
          final isLoading = snapshot.connectionState == ConnectionState.waiting;

          return Layout(
            title: 'Список побед',
            body: WinsList(
              isLoading: isLoading,
              wins: snapshot.data!.toList(),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CreateWinScreen.path),
            ),
          );
        });
  }
}
