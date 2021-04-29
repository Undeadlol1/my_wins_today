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
  late Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    /*
     Make sure only single future is created to
     avoid redirection during hot reload.
     https://github.com/flutter/flutter/issues/60709#issuecomment-749778081
    */
    _initialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return widget.onError(snapshot.error);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          _setupOrDisableFirebaseEmulator();
          return widget.onDidInitilize(snapshot.data);
        }
        return widget.onLoading();
      },
    );
  }

  void _setupOrDisableFirebaseEmulator() async {
    final firestore = FirebaseFirestore.instance;

    if (widget.shouldEmulatorStart) {
      log('Enabling firebase emulator.');
      String host = defaultTargetPlatform == TargetPlatform.android
          ? '10.0.2.2:8080'
          : 'localhost:8080';

      // https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
      firestore.settings = Settings(host: host, sslEnabled: false);
    } else {
      firestore.settings = Settings();
    }
  }
}
