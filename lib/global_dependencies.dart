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
    Get.put(ViewerState());
    Get.put(WinsListState());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
        stream: subscribeToViewer(),
        builder: (context, snapshot) {
          return this.widget.child;
        });
  }
}
