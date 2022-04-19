import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubergrass/src/model/users.dart';
import 'package:ubergrass/src/register/register_controller.dart';
import 'package:ubergrass/src/widget/widget/button/progress_button.dart';
import 'package:ubergrass/src/widget/widget/textfield/custom_text_field.dart';
import '../constant/size.dart';
import '../widget/widget/placement/custom_center.dart';

enum UserType { User, Manager }

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String routeName = "/register";
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  UserType? _character = UserType.User;
  RegisterController controller = RegisterController();
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  TextEditingController textEditingControllerRePassword =
      TextEditingController();
  TextEditingController textEditingControllerTelephone =
      TextEditingController();
  ButtonState buttonState = ButtonState.normal;
  bool needPhone = true;

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
                    Text(
                      AppLocalizations.of(context)!.registerTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: largeTextSize, fontWeight: FontWeight.bold),
                    ),
                    CustomCenter(
                      padding: EdgeInsets.symmetric(
                          vertical: mediumMargin, horizontal: mediumMargin),
                      child: Column(
                        children: [
                          CustomTextField(
                            labelText: "Name",
                            controller: textEditingControllerName,
                          ),
                          SizedBox(height: mediumMargin),
                          CustomTextField(
                            labelText: "Password",
                            isPassword: true,
                            controller: textEditingControllerPassword,
                          ),
                          SizedBox(height: mediumMargin),
                          CustomTextField(
                            labelText: "Re-enter Password",
                            isPassword: true,
                            controller: textEditingControllerRePassword,
                          ),
                          SizedBox(height: mediumMargin),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                  title: Text(AppLocalizations.of(context)!
                                      .registerTypeUser),
                                  leading: Radio<UserType>(
                                    value: UserType.User,
                                    groupValue: _character,
                                    onChanged: (UserType? value) {
                                      setState(() {
                                        needPhone = true;
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
                                        needPhone = false;
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: mediumMargin),
                          needPhone ? CustomTextField(
                            labelText: "Telephone number",
                            textInputType: TextInputType.phone,
                            controller: textEditingControllerTelephone,
                          ) : Container(),
                        ],
                      ),
                    ),
                    CustomCenter(
                      padding: EdgeInsets.symmetric(
                          vertical: mediumMargin, horizontal: mediumMargin),
                      child: ProgressButton(
                        child: Text(AppLocalizations.of(context)!
                            .registerButton, style: GoogleFonts.montserrat(color: Colors.white),),
                        buttonState: buttonState,
                        onPressed: () {
                          setState(() {
                            buttonState = ButtonState.inProgress;
                          });
                          if (textEditingControllerPassword.text ==
                              textEditingControllerRePassword.text && textEditingControllerPassword.text.isNotEmpty) {
                            controller.createUser(Users(
                                name: textEditingControllerName.text,
                                password: textEditingControllerPassword.text,
                                role: _character!.index,
                                phoneNumber: _character == UserType.User
                                    ? textEditingControllerTelephone.text
                                    : null)).then((_) => {
                                      setState(() {
                                        buttonState = ButtonState.normal;
                                      }),
                            });
                          } else {
                            Future.delayed(const Duration(seconds: 1)).then((value) =>
                            {
                              setState(() {
                                print("err");
                                buttonState = ButtonState.error;
                              })
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
