import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubergrass/src/constant/size.dart';
import 'package:ubergrass/src/widget/widget/placement/custom_center.dart';

class CommandListView extends StatefulWidget {
  const CommandListView({Key? key}) : super(key: key);
  static const String routeName = "/complete_info";
  @override
  State<CommandListView> createState() => _CommandListViewState();
}

class _CommandListViewState extends State<CommandListView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              CustomCenter(
                padding: EdgeInsets.symmetric(vertical: size.height / 8),
                child: Column(
                  children: <Widget>[
                    CustomCenter(
                      padding: EdgeInsets.symmetric(
                          vertical: mediumMargin, horizontal: mediumMargin),
                      child: Text(
                        AppLocalizations.of(context)!.completeTitle,
                        style: GoogleFonts.montserrat(fontSize: largeTextSize, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
