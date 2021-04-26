import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';
import 'package:my_wins_today/use_cases/subscribe_to_viewer.dart';

class GlobalDependencies extends StatefulWidget {
  final Widget child;

  GlobalDependencies({Key? key, required this.child}) : super(key: key);

  @override
  _GlobalDependenciesState createState() => _GlobalDependenciesState();
}

class _GlobalDependenciesState extends State<GlobalDependencies> {
  late Future<FirebaseApp> _firebaseInitialization;

  @override
  void initState() {
    super.initState();
    /*
     Make sure only single future is created to
     avoid redirection during hot reload.
     https://github.com/flutter/flutter/issues/60709#issuecomment-749778081
    */
    log('GLOBAL DEPS INIT STATE IS RUNNING.');
    _firebaseInitialization = Firebase.initializeApp();
    Get.put(ViewerState());
    Get.put(WinsListState());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, AsyncSnapshot<FirebaseApp> firebaseSnapshot) {
        log('firebaseSnapshot status: ' +
            firebaseSnapshot.connectionState.toString());
        if (firebaseSnapshot.error != null) {
          return _logAndDisplayErrorText(firebaseSnapshot.error ?? {});
        }

        if (firebaseSnapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: subscribeToViewer(),
            builder: (context, viewerSnapshot) {
              log('viewerSnapshot status: ' +
                  viewerSnapshot.connectionState.toString());
              if (_isViewerLoading(viewerSnapshot)) {
                return _buildLoadingIndicator();
              }
              return this.widget.child;
            },
          );
        }

        return _buildLoadingIndicator();
      },
    );
  }

  bool _isViewerLoading(AsyncSnapshot<Object?> viewerSnapshot) {
    return viewerSnapshot.connectionState == ConnectionState.none ||
        viewerSnapshot.connectionState == ConnectionState.waiting;
  }

  Center _buildLoadingIndicator() => Center(child: CircularProgressIndicator());

  Widget _logAndDisplayErrorText(Object error) {
    log('Something were thrown during Firebase initialization.');
    log(error.toString());
    return Center(child: Text('Firebase Error.'));
  }
}
