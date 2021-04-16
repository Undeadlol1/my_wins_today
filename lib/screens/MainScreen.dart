import 'package:flutter/material.dart';
import 'package:my_wins_today/widgets/WinsList.dart';

import '../entities/Win.dart';

class MainScreen extends StatelessWidget {
  final List<Win> wins;
  const MainScreen({Key? key, required this.wins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WinsList(items: this.wins);
  }
}
