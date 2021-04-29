import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseInitializer extends StatefulWidget {
  final bool shouldEmulatorStart;
  final Widget Function() onLoading;
  final Widget Function(Object?) onError;
  final Widget Function(FirebaseApp?) onDidInitilize;

  const FirebaseInitializer({
    Key? key,
    required this.onError,
    required this.onLoading,
    required this.onDidInitilize,
    required this.shouldEmulatorStart,
  }) : super(key: key);

  @override
  _FirebaseInitializerState createState() => _FirebaseInitializerState();
}

class _FirebaseInitializerState extends State<FirebaseInitializer> {
  late Future<FirebaseApp> initialization;

  @override
  void initState() {
    super.initState();
    /*
     Make sure only single future is created to
     avoid redirection during hot reload.
     https://github.com/flutter/flutter/issues/60709#issuecomment-749778081
    */
    initialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return widget.onError(snapshot.error);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (widget.shouldEmulatorStart) {
            _setupFirebaseEmulator();
          }
          return widget.onDidInitilize(snapshot.data);
        }
        return widget.onLoading();
      },
    );
  }

  void _setupFirebaseEmulator() {
    log('Enabling firebase emulator.');
    // https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
    String host = defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2:8080'
        : 'localhost:8080';

    FirebaseFirestore.instance.settings =
        Settings(host: host, sslEnabled: false);
  }
}
