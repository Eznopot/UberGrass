import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ubergrass/src/page/admin_page/admin_page_view.dart';
import 'package:ubergrass/src/page/article_visualisation/article_visualisation_view.dart';
import 'package:ubergrass/src/page/complete_information/complete_information_view.dart';
import 'package:ubergrass/src/page/edit_article/edit_article_view.dart';
import 'package:ubergrass/src/page/home/buyer/home_buyer_view.dart';
import 'package:ubergrass/src/page/home/seller/home_seller_view.dart';
import 'package:ubergrass/src/page/register/register_view.dart';
import 'package:ubergrass/src/page/select_address/select_adress_view.dart';
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
          initialRoute: "/register",
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case CompleteInformationView.routeName:
                    return const CompleteInformationView();
                  case AdminPageView.routeName:
                    return const AdminPageView();
                  case HomeSellerView.routeName:
                    return const HomeSellerView();
                  case HomeBuyerView.routeName:
                    return const HomeBuyerView();
                  case SelectAddressView.routeName:
                    return SelectAddressView();
                  case EditArticleView.routeName:
                    if (routeSettings.arguments != null) {
                      return EditArticleView(data: routeSettings.arguments);
                    }
                    return const RegisterView();
                  case ArticleVisualisationView.routeName:
                    if (routeSettings.arguments != null) {
                      return ArticleVisualisationView(data: routeSettings.arguments);
                    }
                    return const RegisterView();
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
