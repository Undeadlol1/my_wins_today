import 'package:flutter/material.dart';

import 'StoriesList.dart';
import 'screens/MainScreen.dart';

void main() => runApp(const Application());

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _isStorybookEnabled = true;
    return _isStorybookEnabled
        ? StoriesList()
        : MaterialApp(
            home: MainScreen(myWinsToday: []),
          );
  }
}
