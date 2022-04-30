import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../constant/size.dart';
import '../../../widget/widget/dialog/create_article_dialog/create_article_dialog_widget.dart';
import '../../../widget/widget/dialog/exit_will_pop.dart';
import '../../../widget/widget/drawer.dart';
import '../../../widget/widget/list/listArticle/list_builder.dart';
import '../../edit_article/edit_article_view.dart';
import 'home_seller_controller.dart';

class HomeSellerView extends StatefulWidget {
  const HomeSellerView({Key? key}) : super(key: key);
  static const String routeName = "/home_page_seller";
  @override
  State<HomeSellerView> createState() => _HomeSellerViewState();
}

class _HomeSellerViewState extends State<HomeSellerView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController();
  HomeSellerController controller = HomeSellerController();
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

  removeArticle(int index) {
    if (list != null) {
      listKey.currentState?.removeItem(
          index,
          (_, animation) => ListBuilder(
              position: index,
              animation: animation,
              list: list!,
              scrollController: scrollController,
              onDelete: () => removeArticle(index)),
          duration: const Duration(milliseconds: 200));
    }
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
                                  onDelete: () => removeArticle(index),
                                  onPressed: () {
                                    Navigator.pushNamed(context, EditArticleView.routeName, arguments: list![index]);
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.white,),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const CreateArticleDialog();
              },
            ).then((value) {
              if (value) {
                Navigator.popAndPushNamed(context, HomeSellerView.routeName);
              }
            });
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
