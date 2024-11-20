// import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

// void main() async {
//   // Set up the SettingsController, which will glue user settings to multiple
//   // Flutter Widgets.
//   final settingsController = SettingsController(SettingsService());

//   // Load the user's preferred theme while the splash screen is displayed.
//   // This prevents a sudden theme change when the app is first displayed.
//   await settingsController.loadSettings();

//   // Run the app and pass in the SettingsController. The app listens to the
//   // SettingsController for changes, then passes it further down to the
//   // SettingsView.
//   runApp(MyApp(settingsController: settingsController));
// }

import 'package:flutter/material.dart';
// import 'src/remote_control.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(MyApp(settingsController: settingsController));
  // runApp(MyApp());
}

// class MyApp extends StatelessWidget {
// class MyApp {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pioneer VSX Remote Control',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: RemoteControl(),
//     );
//   }
// }