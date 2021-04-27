import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/states/wins_list_state.dart';

class FirebaseInitializer extends StatefulWidget {
  final Widget Function(BuildContext, FirebaseApp?) onDidInitilize;
  final Widget Function(BuildContext) onLoading;
  final Widget Function(BuildContext, Object?) onError;

  const FirebaseInitializer({
    Key? key,
    required this.onDidInitilize,
    required this.onLoading,
    required this.onError,
  }) : super(key: key);

  @override
  _FirebaseInitializerState createState() => _FirebaseInitializerState();
}

class _FirebaseInitializerState extends State<FirebaseInitializer> {
  late Future<FirebaseApp> initialization;

  @override
  void initState() {
    super.initState();
    Get.put(ViewerState());
    Get.put(WinsListState());
    initialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('error ${snapshot.error.toString()}');
          return widget.onError(context, snapshot.error);
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('ok');
          return widget.onDidInitilize(context, snapshot.data);
        }
        return widget.onLoading(context);
      },
    );
  }
}
