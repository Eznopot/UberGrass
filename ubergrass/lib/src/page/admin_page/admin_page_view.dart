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
  static const String routeName = "/home_page_admin";
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

    const borderBase = Border(
      right: BorderSide(
        width: 1.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );

    return ExitWillPop(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: const Color.fromARGB(255, 99, 156, 86),
                  child: const Center(
                    child: Text('ADMIN WEB CONSOLE'),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: const Color.fromARGB(255, 134, 134, 134),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(50, 0, 0, 0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ContainerBorderWidget(
                                inContainer: const Center(child: Text("User"))),
                            ContainerBorderWidget(
                                inContainer:
                                    const Center(child: Text("Groups"))),
                            ContainerBorderWidget(
                                inContainer:
                                    const Center(child: Text("Roles"))),
                            ContainerBorderWidget(
                                inContainer:
                                    const Center(child: Text("Rights"))),
                            ContainerBorderWidget(
                                flexSize: 4, inContainer: const Text("")),
                          ],
                        ),
                      )),
                ),
              ),
              Expanded(
                flex: 20,
                child: Container(
                  color: const Color.fromARGB(255, 134, 134, 134),
                  child: Row(
                    children: <Widget>[
                      ContainerBorderWidget(
                        flexSize: 3,
                        inContainer: Column(
                          children: <Widget>[
                            ContainerBorderWidget(flexSize: 10),
                            ContainerBorderWidget(flexSize: 10),
                            ContainerBorderWidget(flexSize: 10),

                          ],
                        ),
                      ),
                      ContainerBorderWidget(flexSize: 10),
                      ContainerBorderWidget(flexSize: 3),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerBorderWidget extends StatelessWidget {
  ContainerBorderWidget({
    Key? key,
    this.flexSize,
    this.borderStyle,
    this.inContainer,
  }) : super(key: key);
  int? flexSize;
  Border? borderStyle;
  Widget? inContainer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexSize ?? 1,
      child: Container(
        decoration: BoxDecoration(
          border: borderStyle ??
              const Border(
                right: BorderSide(
                  width: 1.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
        ),
        child: inContainer ?? const Center(child: Text("Default Values")),
      ),
    );
  }
}
