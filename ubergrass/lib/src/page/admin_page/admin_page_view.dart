import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubergrass/src/widget/widget/button/progress_button.dart';
import 'package:ubergrass/src/widget/widget/textfield/custom_text_field.dart';
import '../../widget/widget/dialog/exit_will_pop.dart';
import '../complete_information/complete_information_view.dart';
import '../../constant/size.dart';
import '../../widget/widget/placement/custom_center.dart';
import 'admin_page_controller.dart';

class AdminPageView extends StatefulWidget {
  const AdminPageView({Key? key}) : super(key: key);
  static const String routeName = "/admin_page";
  @override
  State<AdminPageView> createState() => _AdminPageViewState();
}

class _AdminPageViewState extends State<AdminPageView> {
  AdminPageController controller = AdminPageController();
  TextEditingController textEditingControllerFunctionName =
      TextEditingController();
  String result = "";
  ButtonState buttonState = ButtonState.normal;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExitWillPop(
      child: Scaffold(
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
                        child: CustomTextField(
                          labelText: "enterFunctionName",
                          controller: textEditingControllerFunctionName,
                        ),
                      ),
                      CustomCenter(
                        padding: EdgeInsets.symmetric(
                            vertical: mediumMargin, horizontal: mediumMargin),
                        child: ProgressButton(
                          child: Text(
                            "Call function",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                          buttonState: buttonState,
                          onPressed: () {
                            setState(() {
                              buttonState = ButtonState.inProgress;
                            });
                            controller
                                .callCloudFunction(
                                    textEditingControllerFunctionName.text)
                                .then((value) => {
                                      setState(() {
                                        result = value;
                                      })
                                    });
                          },
                        ),
                      ),
                      CustomCenter(
                        padding: EdgeInsets.symmetric(
                            vertical: mediumMargin, horizontal: mediumMargin),
                        child: Text(
                          result,
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
