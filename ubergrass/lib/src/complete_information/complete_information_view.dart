import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubergrass/src/register/register_controller.dart';
import 'package:ubergrass/src/widget/widget/button/progress_button.dart';
import 'package:ubergrass/src/widget/widget/textfield/custom_text_field.dart';
import '../constant/size.dart';
import '../widget/widget/placement/custom_center.dart';
import 'complete_information_controller.dart';

enum UserType { User, Manager }

class CompleteInformationView extends StatefulWidget {
  const CompleteInformationView({Key? key}) : super(key: key);
  static const String routeName = "/complete_info";
  @override
  State<CompleteInformationView> createState() => _CompleteInformationViewState();
}

class _CompleteInformationViewState extends State<CompleteInformationView> {
  UserType? _character = UserType.User;
  CompleteInformationController controller = CompleteInformationController();
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();
  ButtonState buttonState = ButtonState.normal;

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
                    CustomCenter(
                      padding: EdgeInsets.symmetric(
                          vertical: mediumMargin, horizontal: mediumMargin),
                      child: CustomTextField(
                        labelText: AppLocalizations.of(context)!.nameInputTextLabel,
                        controller: textEditingControllerName,
                      ),
                    ),
                    SizedBox(height: mediumMargin),
                    CustomCenter(
                      padding: EdgeInsets.symmetric(
                          vertical: mediumMargin, horizontal: mediumMargin),
                      child: CustomTextField(
                        labelText: AppLocalizations.of(context)!.emailInputTextLabel,
                        controller: textEditingControllerEmail,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                                AppLocalizations.of(context)!.registerTypeUser),
                            leading: Radio<UserType>(
                              value: UserType.User,
                              groupValue: _character,
                              onChanged: (UserType? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(AppLocalizations.of(context)!
                                .registerTypeManager),
                            leading: Radio<UserType>(
                              value: UserType.Manager,
                              groupValue: _character,
                              onChanged: (UserType? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: mediumMargin),
                    CustomCenter(
                      padding: EdgeInsets.symmetric(
                          vertical: mediumMargin, horizontal: mediumMargin),
                      child: ProgressButton(
                        child: Text(
                          AppLocalizations.of(context)!.completeButton,
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                        buttonState: buttonState,
                        onPressed: () {
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
    );
  }
}
