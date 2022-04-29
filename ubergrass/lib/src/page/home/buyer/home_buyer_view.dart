import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../constant/size.dart';
import '../../../widget/widget/dialog/create_article_dialog/create_article_dialog_widget.dart';
import '../../../widget/widget/dialog/exit_will_pop.dart';
import '../../../widget/widget/drawer.dart';
import '../../../widget/widget/list/list_builder.dart';
import '../../../widget/widget/placement/custom_center.dart';
import '../../article_visualisation/article_visualisation_view.dart';
import '../../edit_article/edit_article_view.dart';
import 'home_buyer_controller.dart';

class HomeBuyerView extends StatefulWidget {
  const HomeBuyerView({Key? key}) : super(key: key);
  static const String routeName = "/home_page_buyer";
  @override
  State<HomeBuyerView> createState() => _HomeBuyerViewState();
}

class _HomeBuyerViewState extends State<HomeBuyerView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController();
  HomeBuyerController controller = HomeBuyerController();
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
    controller.getArticles(0, 10).then((value) {
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
              .getArticles(index, MediaQuery.of(context).size.height ~/ 30)
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
                              return ListBuilder(
                                  position: index,
                                  animation: animation,
                                  list: list!,
                                  scrollController: scrollController,
                                  onPressed: () {
                                    Navigator.pushNamed(context, ArticleVisualisationView.routeName, arguments: list![index]);
                                  }
                              );
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
