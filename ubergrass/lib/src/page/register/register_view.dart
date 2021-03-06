import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubergrass/src/page/register/register_controller.dart';
import 'package:ubergrass/src/widget/widget/button/progress_button.dart';
import 'package:ubergrass/src/widget/widget/textfield/custom_text_field.dart';
import '../../widget/widget/dialog/exit_will_pop.dart';
import '../../constant/size.dart';
import '../../widget/widget/dialog/transition_dialog/transition_dialog_widget.dart';
import '../../widget/widget/placement/custom_center.dart';
import '../complete_information/complete_information_view.dart';
enum UserType { User, Manager }

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String routeName = "/register";
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController controller = RegisterController();
  TextEditingController textEditingControllerTelephone =
      TextEditingController();
  ButtonState buttonState = ButtonState.normal;
  bool disposing = false;

  void process(BuildContext context) {
    if (controller.connected && !disposing) {
      disposing = true;
      controller.userCompleted().then((value) {
        if (value) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const TransitionDialog(title: "Loading...", nextPage: 'Home',);
            },
          ).then((value) {
            Navigator.popAndPushNamed(context, value);
          });
        } else {
          Navigator.popAndPushNamed(context, CompleteInformationView.routeName);
        }
      });
    } else {
      setState(() {
        buttonState = ButtonState.error;
      });
    }
  }

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
                          labelText: "Telephone number",
                          textInputType: TextInputType.phone,
                          controller: textEditingControllerTelephone,
                        ),
                      ),
                      CustomCenter(
                        padding: EdgeInsets.symmetric(
                            vertical: mediumMargin, horizontal: mediumMargin),
                        child: ProgressButton(
                          child: Text(
                            AppLocalizations.of(context)!.registerButton,
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                          buttonState: buttonState,
                          onPressed: () {
                            setState(() {
                              buttonState = ButtonState.inProgress;
                            });
                            controller.addListener(() {
                              process(context);
                            });
                            controller.createUser(
                              textEditingControllerTelephone.text, context);
                          },
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
