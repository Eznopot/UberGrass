import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ubergrass/src/firebase/firebase.dart';
import 'package:ubergrass/src/page/settings/settings_controller.dart';
import 'package:ubergrass/src/page/settings/settings_service.dart';
import 'firebase_options.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  FirebasePackage.init(await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,));
  runApp(MyApp(settingsController: settingsController));
}
