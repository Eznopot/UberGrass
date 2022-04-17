import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubergrass/src/register/register_controller.dart';
import 'package:ubergrass/src/widget/widget/button/progress_button.dart';
import 'package:ubergrass/src/widget/widget/textfield/custom_text_field.dart';
import '../constant/size.dart';
import '../firebase/firebase.dart';
import '../widget/widget/placement/custom_center.dart';


class User {
  User({
    required this.name,
  });

  User.fromJson(Map<String, Object?> json)
      : this(
    name: (json['name']! as String),
  );

  final String name;

  Map<String, Object?> toJson() {
    return {
      'name': name,
    };
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String routeName = "/register";
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController controller = RegisterController();
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  TextEditingController textEditingControllerRePassword = TextEditingController();
  TextEditingController textEditingControllerTelephone = TextEditingController();
  ButtonState buttonState = ButtonState.normal;

  @override
  void initState() {
    super.initState();
    FirebasePackage.getDB().collection('User')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
      });
    });
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
                    child: Column(
                      children: [
                        CustomTextField(
                          labelText: "Name",
                        ),
                        SizedBox(height: mediumMargin),
                        CustomTextField(
                          labelText: "Password",
                          isPassword: true,
                        ),
                        SizedBox(height: mediumMargin),
                        CustomTextField(
                          labelText: "Re-enter Password",
                          isPassword: true,
                        ),
                        SizedBox(height: mediumMargin),
                        CustomTextField(
                          labelText: "Telephone number",
                          textInputType: TextInputType.phone,
                        ),
                      ],
                    ),
                ),
                CustomCenter(
                  padding: EdgeInsets.symmetric(
                    vertical: mediumMargin, horizontal: mediumMargin),
                  child: ProgressButton(
                    buttonState: buttonState,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    )));
  }
}
