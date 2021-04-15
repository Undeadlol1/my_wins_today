import 'package:flutter/material.dart';

class TestButton extends StatelessWidget {
  const TestButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: () {},
        color: Colors.blue,
        child: Text(
          'Test',
          style: TextStyle(color: Colors.white),
        ),
      );
}
