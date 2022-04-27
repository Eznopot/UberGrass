import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubergrass/src/widget/widget/button/progress_button.dart';
import 'package:ubergrass/src/widget/widget/textfield/custom_text_field.dart';
import '../../constant/size.dart';
import '../../widget/widget/dialog/exit_will_pop.dart';
import '../../widget/widget/placement/custom_center.dart';
import '../home/home_view.dart';
import 'complete_information_controller.dart';

class CompleteInformationView extends StatefulWidget {
  const CompleteInformationView({Key? key}) : super(key: key);
  static const String routeName = "/complete_info";
  @override
  State<CompleteInformationView> createState() =>
      _CompleteInformationViewState();
}

class _CompleteInformationViewState extends State<CompleteInformationView> {
  String dropdownValue = 'City';
  int roleSelected = 0;
  List<String> city = [];
  List<String> role = [];
  CompleteInformationController controller = CompleteInformationController();
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();
  ButtonState buttonState = ButtonState.normal;

  @override
  void initState() {
    controller.getCities().then((value) {
      if (value != null) {
        setState(() {
          dropdownValue = value[0];
          city = value;
        });
      }
    });
    controller.getRoles().then((value) {
      if (value != null) {
        setState(() {
          role = value;
        });
      }
    });
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
                        child: Text(
                          AppLocalizations.of(context)!.completeTitle,
                          style: GoogleFonts.montserrat(
                              fontSize: largeTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      CustomCenter(
                        padding: EdgeInsets.symmetric(
                            vertical: mediumMargin, horizontal: mediumMargin),
                        child: CustomTextField(
                          labelText:
                              AppLocalizations.of(context)!.nameInputTextLabel,
                          controller: textEditingControllerName,
                        ),
                      ),
                      SizedBox(height: mediumMargin),
                      CustomCenter(
                        padding: EdgeInsets.symmetric(
                            vertical: mediumMargin, horizontal: mediumMargin),
                        child: CustomTextField(
                          labelText:
                              AppLocalizations.of(context)!.emailInputTextLabel,
                          controller: textEditingControllerEmail,
                        ),
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                                AppLocalizations.of(context)!.completeCity,
                                style: GoogleFonts.montserrat()),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Center(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              items: city.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ]),
                      Row(
                        children:
                            List<Widget>.generate(role.length, (int index) {
                          return Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                role[index],
                                style: GoogleFonts.montserrat(
                                    fontSize: mediumTextSize),
                              ),
                              leading: Radio<int>(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: index,
                                groupValue: roleSelected,
                                onChanged: (int? value) {
                                  setState(() {
                                    roleSelected = value!;
                                  });
                                },
                              ),
                            ),
                          );
                        }),
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
                            if (textEditingControllerEmail.text.isNotEmpty && textEditingControllerName.text.isNotEmpty) {
                              setState(() {
                                buttonState = ButtonState.inProgress;
                              });
                              controller.updateInformations(textEditingControllerEmail.text, textEditingControllerName.text, role[roleSelected], dropdownValue).then((value) {
                                if (value == 0) {
                                  setState(() {
                                    buttonState = ButtonState.normal;
                                  });
                                  Navigator.popAndPushNamed(context, HomeView.routeName);
                                } else {
                                  setState(() {
                                    buttonState = ButtonState.error;
                                  });
                                }
                              });
                            }
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
