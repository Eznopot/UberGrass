import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constant/size.dart';
import '../../widget/widget/dialog/exit_will_pop.dart';
import '../../widget/widget/drawer.dart';
import '../../widget/widget/placement/custom_center.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const String routeName = "/home";
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExitWillPop(
      child: Scaffold(
        drawer: MyDrawer(context: context),
        key: scaffoldKey,
        body: Stack(
          children: <Widget>[
            IconButton(
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu, color: Colors.black),
            ),
            CustomCenter(
              padding: EdgeInsets.symmetric(vertical: size.height / 4),
              child: Column(
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.homeTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: largeTextSize, fontWeight: FontWeight.bold),
                  ),
                  CustomCenter(
                    padding: EdgeInsets.symmetric(
                        vertical: mediumMargin, horizontal: mediumMargin),
                    child: Text(
                      AppLocalizations.of(context)!.homeDescription,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: mediumTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
