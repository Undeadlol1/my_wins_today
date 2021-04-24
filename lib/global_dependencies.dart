import 'dart:developer';

import 'package:async_builder/async_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/use_cases/subscribe_to_viewer.dart';

class GlobalDependencies extends StatelessWidget {
  final Widget child;

  GlobalDependencies({
    Key? key,
    required this.child,
  }) : super(key: key);
  final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<void>(
      future: _initialization,
      builder: (context, value) => StreamBuilder<void>(
        stream: subscribeToViewer(),
        builder: (context, _) => this.child,
      ),
      waiting: (context) => Center(child: CircularProgressIndicator()),
      error: (context, error, stackTrace) => _logAndDisplayErrorText(error),
    );
  }

  Widget _logAndDisplayErrorText(Object error) {
    log('Something were thrown during Firebase initialization.');
    log(error.toString());
    return Center(child: Text('Firebase Error.'));
  }
}
