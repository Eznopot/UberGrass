import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ubergrass/src/page/command_list/command_list_view.dart';
import 'package:ubergrass/src/page/complete_information/complete_information_view.dart';
import 'package:ubergrass/src/page/home/home_view.dart';
import 'package:ubergrass/src/page/register/register_view.dart';
import 'package:ubergrass/src/page/settings/settings_controller.dart';
import 'package:ubergrass/src/page/settings/settings_view.dart';
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          initialRoute: "/list_command",
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case HomeView.routeName:
                    return const HomeView();
                  case CompleteInformationView.routeName:
                    return const CompleteInformationView();
                  case CommandListView.routeName:
                    return const CommandListView();
                  default:
                    return const RegisterView();
                }
              },
            );
          },
        );
      },
    );
  }
}
