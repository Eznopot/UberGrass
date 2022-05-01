import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ubergrass/src/widget/widget/button/custom_simple_button.dart';
import 'package:ubergrass/src/widget/widget/button/progress_button.dart';
import 'package:ubergrass/src/widget/widget/textfield/custom_text_field.dart';
import '../../widget/widget/dialog/exit_will_pop.dart';
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

    return kIsWeb
        ? ExitWillPop(
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
                                color: const Color.fromARGB(50, 0, 0, 0),
                              ),
                            ),
                            child: ContainerBorderWidget(
                              flexSize: 10,
                              inContainer: PrintCollection(
                                controller: controller,
                              ),
                            ),
                          ),
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
                              inContainer: Column(
                                children: <Widget>[
                                  ContainerBorderWidget(
                                    flexSize: 20,
                                    inContainer: PrintDocuments(
                                      controller: controller,
                                    ),
                                  ),
                                  ContainerBorderWidget(
                                    inContainer: Center(
                                      child: CustomSimpleButton(
                                        child: const Center(child: Text(" + ")),
                                        onPress: () {
                                          controller.CreateFromDocColl(
                                              controller.Collection);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ContainerBorderWidget(
                              flexSize: 10,
                              inContainer: Column(
                                children: <Widget>[
                                  ContainerBorderWidget(
                                    flexSize: 20,
                                    inContainer:
                                        modifyData(controller: controller),
                                  ),
                                  ContainerBorderWidget(
                                    inContainer: Row(
                                      children: <Widget>[
                                        ContainerBorderWidget(
                                          inContainer: const Text("  Key : "),
                                          borderStyle: const Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0x00000000),
                                            ),
                                          ),
                                        ),
                                        ContainerBorderWidget(
                                          borderStyle: const Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0x00000000),
                                            ),
                                          ),
                                          flexSize: 2,
                                          inContainer: CustomTextField(
                                            changed: (data) {
                                              controller.dKey = data;
                                            },
                                          ),
                                        ),
                                        ContainerBorderWidget(
                                          inContainer: const Text("  Value : "),
                                          borderStyle: const Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0x00000000),
                                            ),
                                          ),
                                        ),
                                        ContainerBorderWidget(
                                          flexSize: 5,
                                          borderStyle: const Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0x00000000),
                                            ),
                                          ),
                                          inContainer: CustomTextField(
                                            changed: (data) {
                                              controller.ChangesData[
                                                  controller.dKey ??
                                                      "NUll"] = data;
                                            },
                                          ),
                                        ),
                                        ContainerBorderWidget(
                                          borderStyle: const Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(0x00000000),
                                            ),
                                          ),
                                          flexSize: 1,
                                          inContainer: Center(
                                            child: CustomSimpleButton(
                                              child: const Text(" + "),
                                              onPress: () {
                                                controller.SetDataFromDocColl(
                                                    controller.dKey ?? "NULL");
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
          )
        : const Center(
            child: Text("Only Web"),
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
                        flexSize: 8,
                        borderStyle: const Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Color(0xFF000000),
                          ),
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
                        flexSize: 32,
                        borderStyle: const Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Color(0xFF000000),
                          ),
                        ),
                        inContainer: Center(
                          child: WriteData(
                            controller: controller,
                            data: controller.AllData!.entries
                                .toList()[index]
                                .value,
                            KKey:
                                controller.AllData!.entries.toList()[index].key,
                          ),
                        ),
                      ),
                      ContainerBorderWidget(
                        borderStyle: const Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Color(0xFF000000),
                          ),
                        ),
                        inContainer: const Center(
                          child: Text(""),
                        ),
                      ),
                      ContainerBorderWidget(
                        flexSize: 2,
                        borderStyle: const Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Color(0xFF000000),
                          ),
                        ),
                        inContainer: Center(
                          child: CustomSimpleButton(
                            onPress: () {
                              controller.SetDataFromDocColl(controller
                                      .AllData!.entries
                                      .toList()[index]
                                      .key
                                      .toString())
                                  .then((_) {
                                controller.GetDocFromCall(
                                  controller.Collection,
                                  controller.Document,
                                );
                              });
                            },
                            child: const Text(
                              "  +  ",
                            ),
                          ),
                        ),
                      ),
                      ContainerBorderWidget(
                        borderStyle: const Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Color(0xFF000000),
                          ),
                        ),
                        inContainer: const Center(
                          child: Text(""),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        : const Center(child: Text("Empty"));
  }
}

class WriteData extends StatelessWidget {
  WriteData({
    Key? key,
    required this.KKey,
    required this.controller,
    required this.data,
  }) : super(key: key);
  AdminPageController controller;
  dynamic data;
  String KKey;

  @override
  Widget build(BuildContext context) {
    return data is String
        ? CustomTextField(
            changed: (data) {
              controller.ChangesData[KKey] = data;
            },
          )
        : Text(data.toString());
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
                          right: BorderSide(
                            width: 1.0,
                            color: Color(0xFF000000),
                          ),
                          bottom: BorderSide(
                            width: 1.0,
                            color: Color(0xFF000000),
                          ),
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
        : const Center(child: Text("Empty"));
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
                  child: Row(
                    children: <Widget>[
                      ContainerBorderWidget(
                        borderStyle: const Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Color(0x0),
                          ),
                        ),
                        flexSize: 8,
                        inContainer: CustomSimpleButton(
                          onPress: () {
                            print("PrintDocuments");
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
                      ContainerBorderWidget(
                        borderStyle: const Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Color(0x00000000),
                          ),
                        ),
                        inContainer: CustomSimpleButton(
                          onPress: () {
                            controller.deleteFromDocColl(controller.Collection, controller.AllDocuments![index]["id"]);
                          },
                          child: const Center(child: Text(" - ")),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        : const Center(child: Text("Empty"));
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
                borderStyle: const Border(
                  bottom: BorderSide(width: 1.0, color: Color(0x00000000)),
                ),
                inContainer: Center(
                  child: CustomSimpleButton(
                    onPress: () {
                      print("PrintCollection");
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
        : const Center(child: Text("Empty"));
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
