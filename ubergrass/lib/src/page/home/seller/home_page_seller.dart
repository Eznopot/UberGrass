import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../constant/size.dart';
import '../../../widget/widget/dialog/exit_will_pop.dart';
import '../../../widget/widget/drawer.dart';
import '../../../widget/widget/placement/custom_center.dart';

class HomeSellerView extends StatefulWidget {
  const HomeSellerView({Key? key}) : super(key: key);
  static const String routeName = "/home";
  @override
  State<HomeSellerView> createState() => _HomeSellerViewState();
}

class _HomeSellerViewState extends State<HomeSellerView> {
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
        floatingActionButton: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {  },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
