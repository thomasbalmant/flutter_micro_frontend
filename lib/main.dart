import 'package:base_app/service/app_deep_links.dart';
import 'package:base_app/signin-page.dart';
import 'package:core/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final updater = ShorebirdUpdater();
  final AppLinksDeepLink _appLinksDeepLink =
      AppLinksDeepLink.instance; // Initialize AppLinksDeepLink instance

  @override
  void initState() {
    super.initState();
    _appLinksDeepLink.onInit();
    updater.readCurrentPatch().then((currentPatch) {
      print('The current patch number is: ${currentPatch?.number}');
    });
    _checkForUpdates();
  }

  Future<void> _checkForUpdates() async {
    final status = await updater.checkForUpdate();

    if (status == UpdateStatus.outdated) {
      try {
        await updater.update();
      } on UpdateException catch (error) {
        // Handle any errors that occur while updating.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _appLinksDeepLink
        .initDeepLinks(); // Initialize deep links when the app starts
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SigninPage(),
    );
  }
}
