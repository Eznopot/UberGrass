import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:ubergrass/src/widget/widget/button/progress_button.dart';
import '../../constant/size.dart';
import '../../widget/widget/dialog/loading_dialog.dart';
import '../home/seller/home_seller_view.dart';
import 'article_visualisation_controller.dart';

class ArticleVisualisationView extends StatefulWidget {
  const ArticleVisualisationView({Key? key, required this.data})
      : super(key: key);
  static const String routeName = "/edit_article";

  final dynamic data;
  @override
  State<ArticleVisualisationView> createState() =>
      _ArticleVisualisationViewState();
}

class _ArticleVisualisationViewState extends State<ArticleVisualisationView> {
  ArticleVisualisationController controller = ArticleVisualisationController();
  ButtonState buttonState = ButtonState.normal;
  String buttonString = "";
  int quantitySelected = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    buttonString = "Buy " + (widget.data["data"]["Weight"] * quantitySelected).toString() + "g for " + (quantitySelected * widget.data["data"]["Price"]).toString() + "€";
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeSellerView.routeName);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.articleVisualisationViewTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: largeTextSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: bigMargin,
              ),
              Text(
                widget.data["data"]["Name"],
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: largeTextSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: mediumMargin,
              ),
              Text(
                "Price: " +
                    widget.data["data"]["Price"].toString() +
                    "for " +
                    widget.data["data"]["Weight"].toString() +
                    "g",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: largeTextSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: mediumMargin,
              ),
              Row(children: [
                Text(
                  AppLocalizations.of(context)!.articleVisualisationViewQuantity,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: largeTextSize, fontWeight: FontWeight.bold),
                ),
                NumberPicker(
                  value: quantitySelected,
                  minValue: 1,
                  maxValue: widget.data["data"]["Quantity"],
                  onChanged: (value) =>
                      setState(() {

                        quantitySelected = value;
                      }),
                ),
              ]),
              SizedBox(
                height: mediumMargin,
              ),
              ProgressButton(buttonState: buttonState, child: Text(
                buttonString,
                style: GoogleFonts.montserrat(color: Colors.white),
              ), onPressed: () {
                setState(() {
                  buttonState = ButtonState.inProgress;
                });
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const LoadingDialog(title: "Uploading change");
                    });
                controller
                    .buyArticle(widget.data["id"], quantitySelected)
                    .then((value) {
                      if (value) {
                        setState(() {
                          buttonState = ButtonState.normal;
                        });
                        Navigator.of(context).pop(true);
                        Navigator.popAndPushNamed(
                            context, HomeSellerView.routeName);
                      } else {
                        setState(() {
                          buttonState = ButtonState.error;
                        });
                        Navigator.of(context).pop(true);
                      }
                });
              }),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
