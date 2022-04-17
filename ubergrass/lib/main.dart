import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ubergrass/src/firebase/firebase.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  FirebasePackage.init(await Firebase.initializeApp());
  runApp(MyApp(settingsController: settingsController));
}
