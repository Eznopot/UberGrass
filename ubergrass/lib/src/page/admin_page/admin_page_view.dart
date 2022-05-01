import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubergrass/src/widget/widget/button/custom_simple_button.dart';
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

    controller.addListener(() {
      setState(() {});
    });

    controller.GetAllCollections();
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
                        child: PrintCollection(
                          controller: controller,
                        )),
                  ),
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
                          inContainer: PrintDocuments(
                            controller: controller,
                          )),
                      ContainerBorderWidget(
                        flexSize: 10,
                        inContainer: modifyData(controller: controller),
                      ),
                      ContainerBorderWidget(
                        flexSize: 5,
                        inContainer: PrintData(controller: controller),
                      ),
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

class modifyData extends StatelessWidget {
  modifyData({
    Key? key,
    required this.controller,
  }) : super(key: key);
  AdminPageController controller;
  @override
  Widget build(BuildContext context) {
    return controller.AllData != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:
                List<Widget>.generate(controller.AllData!.length, (int index) {
              return ContainerBorderWidget(
                inContainer: Center(
                  child: Row(
                    children: <Widget>[
                      ContainerBorderWidget(
                        flexSize: 1,
                        borderStyle: const Border(
                          bottom:
                              BorderSide(width: 1.0, color: Color(0xFF000000)),
                        ),
                        inContainer: Center(
                          child: Text(
                            controller.AllData!.entries
                                .toList()[index]
                                .key
                                .toString(),
                          ),
                        ),
                      ),
                      ContainerBorderWidget(
                        flexSize: 4,
                        borderStyle: const Border(
                          bottom:
                              BorderSide(width: 1.0, color: Color(0xFF000000)),
                        ),
                        inContainer: Center(
                          child: WriteData()
                          }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        : const Text("Empty");
  }
}
class WriteData extends StatelessWidget {
  WriteData({
    Key? key,
    required this.controller,
  }) : super(key: key);
  AdminPageController controller;

  @override
  Widget build(BuildContext context) {
    return
  }
}

class PrintData extends StatelessWidget {
  PrintData({
    Key? key,
    required this.controller,
  }) : super(key: key);
  AdminPageController controller;

  @override
  Widget build(BuildContext context) {
    return controller.AllData != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:
                List<Widget>.generate(controller.AllData!.length, (int index) {
              return ContainerBorderWidget(
                inContainer: Center(
                  child: Row(
                    children: <Widget>[
                      ContainerBorderWidget(
                        flexSize: 1,
                        borderStyle: const Border(
                          right:
                              BorderSide(width: 1.0, color: Color(0xFF000000)),
                          bottom:
                              BorderSide(width: 1.0, color: Color(0xFF000000)),
                        ),
                        inContainer: Center(
                          child: Text(
                            controller.AllData!.entries
                                .toList()[index]
                                .key
                                .toString(),
                          ),
                        ),
                      ),
                      ContainerBorderWidget(
                        flexSize: 4,
                        borderStyle: const Border(
                          right:
                              BorderSide(width: 1.0, color: Color(0xFF000000)),
                          bottom:
                              BorderSide(width: 1.0, color: Color(0xFF000000)),
                        ),
                        inContainer: Center(
                          child: Text(
                            controller.AllData!.entries
                                .toList()[index]
                                .value
                                .toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        : const Text("Empty");
  }
}

class PrintDocuments extends StatelessWidget {
  PrintDocuments({
    Key? key,
    required this.controller,
  }) : super(key: key);
  AdminPageController controller;

  @override
  Widget build(BuildContext context) {
    return controller.AllDocuments != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List<Widget>.generate(controller.AllDocuments!.length,
                (int index) {
              return ContainerBorderWidget(
                inContainer: Center(
                  child: CustomSimpleButton(
                    onPress: () {
                      controller.Document =
                          controller.AllDocuments![index]["id"];
                      controller.GetDocFromCall(
                        controller.Collection,
                        controller.Document,
                      );
                    },
                    child: Text(
                      controller.AllDocuments![index]["id"],
                    ),
                  ),
                ),
              );
            }),
          )
        : const Text("Empty");
  }
}

class PrintCollection extends StatelessWidget {
  PrintCollection({
    Key? key,
    required this.controller,
  }) : super(key: key);
  AdminPageController controller;

  @override
  build(BuildContext context) {
    return controller.AllCollections != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List<Widget>.generate(controller.AllCollections!.length,
                (int index) {
              return ContainerBorderWidget(
                inContainer: Center(
                  child: CustomSimpleButton(
                    onPress: () {
                      controller.Collection =
                          controller.AllCollections![index]["id"];
                      controller.GetRefDocOfCollections(
                        controller.Collection,
                      );
                    },
                    child: Text(
                      controller.AllCollections![index]["id"],
                    ),
                  ),
                ),
              );
            }),
          )
        : const Text("Empty");
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
        child: inContainer ??
            const Center(
              child: Text("Default Values"),
            ),
      ),
    );
  }
}
