import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../constant/size.dart';
import '../../../widget/widget/dialog/exit_will_pop.dart';
import '../../../widget/widget/dialog/loading_dialog.dart';
import '../../../widget/widget/drawer.dart';
import '../../../widget/widget/list/listOrder/list_builder.dart';
import '../../article_visualisation/article_visualisation_view.dart';
import '../../delivery_page/delivery_page_view.dart';
import 'home_delivery_controller.dart';

class HomeDeliveryView extends StatefulWidget {
  const HomeDeliveryView({Key? key}) : super(key: key);
  static const String routeName = "/home_page_delivery";
  @override
  State<HomeDeliveryView> createState() => _HomeDeliveryViewState();
}

class _HomeDeliveryViewState extends State<HomeDeliveryView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController();
  HomeDeliveryController controller = HomeDeliveryController();
  List<dynamic>? list;
  bool isInserted = true;

  insertArticle(int index) {
    if (list == null) return;
    for (var i = index; i < list!.length; i++) {
      listKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 200));
    }
    isInserted = true;
  }

  reloadArticle() {
    if (list == null) return;
    for (var i = 0; i < list!.length; i++) {
      listKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 200));
    }
  }

  loadArticle() {
    if (list == null) return;
    for (var i = 0; i < list!.length; i++) {
      listKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 200));
    }
  }

  @override
  void initState() {
    controller.getOrders(0, 10).then((value) {
      list = value;
      setState(() {
        loadArticle();
      });
    });
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = 200.0;
      if (list != null) {
        int index = list!.length;
        if (maxScroll - currentScroll <= delta && isInserted) {
          controller
              .getOrders(index, MediaQuery.of(context).size.height ~/ 30)
              .then((value) {
            if (value != null) {
              list!.addAll(value);
              insertArticle(index);
            }
          });
          isInserted = false;
        } else {
          Future.delayed(const Duration(seconds: 1)).then((value) {
            isInserted = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExitWillPop(
      child: Scaffold(
        drawer: MyDrawer(context: context),
        key: scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu, color: Colors.black),
              ),
              Column(
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.homeTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: largeTextSize, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: mediumMargin),
                  list != null
                      ? Expanded(
                          child: AnimatedList(
                            controller: scrollController,
                            key: listKey,
                            shrinkWrap: true,
                            initialItemCount: list?.length ?? 0,
                            itemBuilder: (context, index, animation) {
                              return ListBuilderOrder(
                                  position: index,
                                  animation: animation,
                                  list: list!,
                                  scrollController: scrollController,
                                  onAccept: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const LoadingDialog(
                                              title: "Buying...");
                                        });
                                    controller
                                        .acceptOrder(list![index]["id"])
                                        .then((value) {
                                      if (value) {
                                        Navigator.of(context).pop(true);
                                        if (value) {
                                          Navigator.of(context).pushNamed(DeliveryPageView.routeName);
                                        }
                                      }
                                    });
                                  });
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
