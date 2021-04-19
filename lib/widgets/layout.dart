import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final String title;
  final Widget body;
  const Layout({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: this.body,
      drawer: Drawer(
        child: _linksList(),
      ),
    );
  }

  Widget _linksList() {
    return ListView(
      children: [
        ListTile(
          title: TextButton(
            onPressed: () {},
            child: ListTile(
              title: Text('Войти'),
            ),
          ),
        )
      ],
    );
  }
}
