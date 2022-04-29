import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubergrass/src/widget/widget/dialog/save_will_pop.dart';
import '../../constant/size.dart';
import '../../widget/widget/dialog/loading_dialog.dart';
import '../../widget/widget/drawer.dart';
import '../../widget/widget/textfield/custom_text_field.dart';
import '../home/seller/home_seller_view.dart';
import 'edit_article_controller.dart';

class EditArticleView extends StatefulWidget {
  const EditArticleView({Key? key, required this.data}) : super(key: key);
  static const String routeName = "/edit_article";

  final dynamic data;
  @override
  State<EditArticleView> createState() => _EditArticleViewState();
}

class _EditArticleViewState extends State<EditArticleView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  EditArticleController controller = EditArticleController();

  @override
  void initState() {
    titleController.text = widget.data["data"]["Name"];
    priceController.text = widget.data["data"]["Price"].toString();
    quantityController.text = widget.data["data"]["Quantity"].toString();
    weightController.text = widget.data["data"]["Weight"].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                AppLocalizations.of(context)!.editArticleViewTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: largeTextSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: bigMargin,
              ),
              EditWidget(
                  titleController: titleController,
                  text: AppLocalizations.of(context)!.editArticleViewName),
              SizedBox(
                height: mediumMargin,
              ),
              EditWidget(
                  titleController: priceController,
                  text: AppLocalizations.of(context)!.editArticleViewPrice),
              SizedBox(
                height: mediumMargin,
              ),
              EditWidget(
                  titleController: quantityController,
                  text: AppLocalizations.of(context)!.editArticleViewQuantity),
              SizedBox(
                height: mediumMargin,
              ),
              EditWidget(
                  titleController: weightController,
                  text: AppLocalizations.of(context)!.editArticleViewWeight),
            ],
          ),
        ),
        floatingActionButton: IconButton(
          color: Colors.greenAccent,
          icon: const Icon(Icons.edit),
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const LoadingDialog(title: "Uploading change");
                });
            controller
                .editArticle(
                    titleController.text,
                    double.parse(priceController.text),
                    int.parse(quantityController.text),
                    double.parse(weightController.text),
                    widget.data["id"])
                .then((value) {
              Navigator.of(context).pop(true);
              Navigator.popAndPushNamed(context, HomeSellerView.routeName);
            });
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class EditWidget extends StatelessWidget {
  const EditWidget(
      {Key? key, required this.titleController, required this.text})
      : super(key: key);

  final TextEditingController titleController;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: mediumTextSize, fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          flex: 3,
          child: CustomTextField(
            labelText: text,
            controller: titleController,
          ),
        ),
      ],
    );
  }
}
