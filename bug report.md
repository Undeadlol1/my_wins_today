## Bug report

**Describe the bug**

Recently I connected to a local emulator using instructions from the documentation:
https://firebase.flutter.dev/docs/firestore/usage#emulator-usage

The connection was successful and the application used the emulator as a local database.
A problem occurred when I tried to connect to a live database again. I could not do it. No matter how much I tried to reset values of "FirebaseFirestore.instance.settings" nothing worked.

### Steps to reproduce

Steps to reproduce the behavior:

1. Clone reproduction branch `https://github.com/Undeadlol1/my_wins_today/tree/repro/live-db-connection-problem`
2. Run the firestore emulator. The command is: `firebase emulators:start --only firestore`
3. You are going to see "everything is fine" in the middle of the screen. So far so good.
4. Stop the emulator.
5. Go to main.dart and change value of "isFirebaseEmulatorEnabled" to "false";
6. Restart the project.
7. You are going to witness infinite loading animation on the screen and errors in debug log.

### Expected behavior

I would like to connect to the live firestore database.

### Flutter doctor

Run `flutter doctor` and paste the output below:

<details><summary>Click To Expand</summary>

```
[√] Flutter (Channel dev, 2.2.0-10.1.pre, on Microsoft Windows [Version    10.0.18363.1440], locale ru-RU)
[√] Android toolchain - develop for Android devices (Android SDK
    version 29.0.2)
[√] Chrome - develop for the web
[√] Android Studio (version 4.1.0)
[√] VS Code, 64-bit edition (version 1.55.2)
[√] Connected device (2 available)

• No issues found!
```

</details>

---

### Flutter dependencies

Run `flutter pub deps -- --style=compact` and paste the output below:

<details><summary>Click To Expand</summary>

```
Dart SDK 2.13.0-211.6.beta
Flutter SDK 2.2.0-10.1.pre
my_wins_today 1.0.0+1

dependencies:
- async_builder 1.3.0 [flutter rxdart]
- cloud_firestore 1.0.6 [cloud_firestore_platform_interface cloud_firestore_web firebase_core firebase_core_platform_interface flutter meta]
- firebase_auth 1.1.1 [firebase_auth_platform_interface firebase_auth_web firebase_core firebase_core_platform_interface flutter meta]
- firebase_core 1.0.4 [firebase_core_platform_interface firebase_core_web flutter meta]
- flutter 0.0.0 [characters collection meta typed_data vector_math sky_engine]
- get 4.1.4 [flutter]
- google_sign_in 5.0.2 [google_sign_in_platform_interface google_sign_in_web flutter meta]
- shimmer 2.0.0 [flutter]
- storybook_flutter 0.5.0 [collection device_frame dfunc flutter freezed_annotation provider recase]
- uuid 3.0.4 [crypto]

dev dependencies:
- flutter_test 0.0.0 [flutter test_api path fake_async clock stack_trace vector_math async boolean_selector characters charcode collection matcher meta source_span stream_channel string_scanner term_glyph typed_data]

transitive dependencies:
- async 2.5.0 [collection]
- boolean_selector 2.1.0 [source_span string_scanner]
- characters 1.1.0
- charcode 1.2.0
- clock 1.1.0
- cloud_firestore_platform_interface 4.0.2 [collection firebase_core flutter meta plugin_platform_interface]
- cloud_firestore_web 1.0.6 [cloud_firestore_platform_interface firebase_core firebase_core_web flutter flutter_web_plugins js]
- collection 1.15.0
- crypto 3.0.1 [collection typed_data]
- device_frame 0.4.0 [flutter_svg path_drawing freezed_annotation flutter]
- dfunc 0.6.2
- fake_async 1.2.0 [clock collection]
- firebase_auth_platform_interface 4.1.1 [firebase_core flutter meta plugin_platform_interface]
- firebase_auth_web 1.0.7 [firebase_auth_platform_interface firebase_core firebase_core_web flutter flutter_web_plugins http_parser intl js meta]
- firebase_core_platform_interface 4.0.0 [flutter meta plugin_platform_interface]
- firebase_core_web 1.0.2 [firebase_core_platform_interface flutter flutter_web_plugins js meta]
- flutter_svg 0.21.0+1 [flutter meta path_drawing vector_math xml]
- flutter_web_plugins 0.0.0 [flutter js characters collection meta typed_data vector_math]
- freezed_annotation 0.14.1 [collection json_annotation meta]
- google_sign_in_platform_interface 2.0.1 [flutter meta quiver]
- google_sign_in_web 0.10.0 [google_sign_in_platform_interface flutter
flutter_web_plugins meta js]
- http_parser 4.0.0 [charcode collection source_span string_scanner typed_data]
- intl 0.17.0 [clock path]
- js 0.6.3
- json_annotation 4.0.1
- matcher 0.12.10 [stack_trace]
- meta 1.3.0
- nested 1.0.0 [flutter]
- path 1.8.0
- path_drawing 0.5.0 [vector_math meta path_parsing flutter]
- path_parsing 0.2.0 [vector_math meta]
- petitparser 4.1.0 [meta]
- plugin_platform_interface 2.0.0 [meta]
- provider 5.0.0 [collection flutter nested]
- quiver 3.0.1 [matcher]
- recase 4.0.0-nullsafety.0
- rxdart 0.26.0
- sky_engine 0.0.99
- source_span 1.8.1 [collection path term_glyph]
- stack_trace 1.10.0 [path]
- stream_channel 2.1.0 [async]
- string_scanner 1.1.0 [charcode source_span]
- term_glyph 1.2.0
- test_api 0.3.0 [async boolean_selector collection meta path source_span stack_trace stream_channel string_scanner term_glyph matcher]
- typed_data 1.3.0 [collection]
- vector_math 2.1.0
- xml 5.1.0 [collection meta petitparser]
```

</details>

---

## Additional context

When I checked out into an earlier branch of my project the issue was resolved and I was able to connect to the live database. I have no idea why one version of the code works fine and the other does not.

<details><summary>main.dart</summary>
```dart
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:my_wins_today/global_dependencies.dart';
import 'package:my_wins_today/screens/create_win_screen.dart';
import 'package:my_wins_today/screens/main_screen_container.dart';
import 'firebase_initializer.dart';
import 'screens/sign_in_screen.dart';
import 'stories_list.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
runApp(Application());
}

class Application extends StatelessWidget {
@override
Widget build(BuildContext context) {
const isStorybookEnabled = false;
const isFirebaseEmulatorEnabled = false;

    if (isStorybookEnabled) {
      return StoriesList();
    }

    return FirebaseInitializer(
      onError: _logAndDisplayErrorText,
      onLoading: _buildLoadingIndicator,
      onDidInitilize: (_) {
        return GlobalDependencies(
          child: GetMaterialApp(
            routes: _buildRoutes(),
            home: MainScreenContainer(),
          ),
        );
      },
      shouldEmulatorStart: isFirebaseEmulatorEnabled,
    );

}

Map<String, Widget Function(BuildContext)> \_buildRoutes() {
return {
SignInScreen.path: (context) => SignInScreen(),
CreateWinScreen.path: (context) => CreateWinScreen(wins: []),
};
}

Widget \_buildLoadingIndicator() {
return MaterialApp(
home: Center(
child: CircularProgressIndicator(),
),
);
}

Widget \_logAndDisplayErrorText(Object? error) {
log('Something were thrown during Firebase initialization.');
log(error.toString());
return MaterialApp(
home: Center(
child: Text('Firebase Error.'),
),
);
}
}

````
</details>
<details><summary>firerbase_initializer.dart (this one does not work)</summary>
```dart
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

````

</details>
