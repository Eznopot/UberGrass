import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constant/size.dart';
import '../widget/widget/placement/custom_center.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String routeName = "/register";
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomCenter(
            padding: EdgeInsets.symmetric(vertical: size.height / 4),
            child: Column(
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.registerTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: largeTextSize, fontWeight: FontWeight.bold),
                ),
                CustomCenter(
                  padding: EdgeInsets.symmetric(
                      vertical: mediumMargin, horizontal: mediumMargin),
                  child: Text(
                    "",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: mediumTextSize, fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
