import 'package:flutter/material.dart';
import 'package:my_wins_today/screens/MainScreen.dart';
import 'package:my_wins_today/widgets/CreateWinForm.dart';
import 'package:my_wins_today/widgets/WinsList.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'screens/CreateWinScreen.dart';
import 'entities/Win.dart';

class StoriesList extends StatelessWidget {
  StoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Storybook(
      storyWrapperBuilder: (context, story, child) => Stack(
        children: [
          Container(
            padding: story.padding,
            child: Center(child: child),
            color: Theme.of(context).canvasColor,
          ),
        ],
      ),
      children: [
        Story.simple(
          name: 'MainScreen',
          child: MainScreen(
            wins: _wins,
          ),
        ),
        Story.simple(
          name: 'CreateWinScreen',
          child: CreateWinScreen(
            wins: _wins,
          ),
        ),
        Story.simple(name: 'WinsList', child: WinsList(items: _wins)),
        Story.simple(
            name: 'CreateWinForm',
            child: CreateWinForm(
              myWinsToday: [],
            )),
        Story(
          section: 'CreateWinForm',
          name: 'Flat button',
          builder: (_, k) => CreateWinForm(
            myWinsToday: _wins,
            // onPressed:
            //     k.boolean(label: 'Enabled', initial: true) ? () {} : null,
          ),
        ),
        // Story(
        //   section: 'Buttons',
        //   name: 'Raised button',
        //   // ignore: deprecated_member_use
        //   builder: (_, k) => RaisedButton(
        //     onPressed:
        //         k.boolean(label: 'Enabled', initial: true) ? () {} : null,
        //     color: k.options(
        //       label: 'Color',
        //       initial: Colors.deepOrange,
        //       options: const [
        //         Option('Red', Colors.deepOrange),
        //         Option('Green', Colors.teal),
        //       ],
        //     ),
        //     mouseCursor: k.options(
        //       label: 'Mouse Cursor',
        //       initial: null,
        //       options: const [
        //         Option('Basic', SystemMouseCursors.basic),
        //         Option('Click', SystemMouseCursors.click),
        //         Option('Forbidden', SystemMouseCursors.forbidden),
        //       ],
        //     ),
        //     elevation: k.slider(label: 'Elevation', initial: 0, max: 20),
        //     textColor: Colors.white,
        //     child: Text(k.text(label: 'Text', initial: 'Raised button')),
        //   ),
        // ),
      ],
    );
  }

  final List<Win> _wins = [
    Win(
      title: 'Поздравил Деда',
      id: '321',
      userId: '123',
      updatedAt: 123,
      createdAt: 123,
    ),
    Win(
      title: 'Отправил документы',
      id: '123',
      userId: '123',
      updatedAt: 123,
      createdAt: 123,
    ),
  ];
}
