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
      drawer: Drawer(
        child: _linksList(),
      ),
      body: Padding(
        child: this.body,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
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
              title: Text(
                'Войти',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
