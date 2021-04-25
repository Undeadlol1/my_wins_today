import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_wins_today/use_cases/subscribe_to_viewer.dart';

class GlobalDependencies extends StatefulWidget {
  final Widget child;

  GlobalDependencies({Key? key, required this.child}) : super(key: key);

  @override
  _GlobalDependenciesState createState() => _GlobalDependenciesState();
}

class _GlobalDependenciesState extends State<GlobalDependencies> {
  late Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
    /*
     Make sure only single future is created to
     avoid redirection during hot reload.
     https://github.com/flutter/flutter/issues/60709#issuecomment-749778081
    */
    _firebaseInitialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, AsyncSnapshot<FirebaseApp> snapshot) {
        log('snapshot: ' + snapshot.toString());
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.error != null) {
          return _logAndDisplayErrorText(snapshot.error ?? {});
        }
        return StreamBuilder<void>(
          stream: subscribeToViewer(),
          builder: (context, _) => this.widget.child,
        );
      },
    );
  }

  Widget _logAndDisplayErrorText(Object error) {
    log('Something were thrown during Firebase initialization.');
    log(error.toString());
    return Center(child: Text('Firebase Error.'));
  }
}
