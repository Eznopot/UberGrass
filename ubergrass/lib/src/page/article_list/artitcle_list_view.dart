import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubergrass/src/constant/size.dart';
import 'package:ubergrass/src/widget/widget/placement/custom_center.dart';

import '../../widget/widget/dialog/exit_will_pop.dart';
import '../../widget/widget/dialog/loading_dialog.dart';
import '../../widget/widget/list/list_builder.dart';
import '../../widget/widget/list/list_element.dart';

class ArticleListView extends StatefulWidget {
  const ArticleListView({Key? key}) : super(key: key);
  static const String routeName = "/list_command";
  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  bool isInserted = true;
  final ScrollController scrollController = ScrollController();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final Map<String, List<String>> list = {
    "titles": ["test", "frsfsfes", "fesfesfes"],
  };

  insertArticle(int index) {
    if (list["titles"] == null) return;
    for (var i = index; i < list["titles"]!.length; i++) {
      listKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 200));
    }
    isInserted = true;
  }

  removeArticle(int index) {
    listKey.currentState?.removeItem(
        index, (_, animation) => ListBuilder(position: index, animation: animation, list: list, scrollController: scrollController, onDelete: () => removeArticle(index)),
        duration: const Duration(milliseconds: 200));
  }

  loadArticle() {
    if (list["titles"] == null) return;
    for (var i = 0; i < list["titles"]!.length; i++) {
      listKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 200));
    }
  }

  @override
  void initState() {
    loadArticle();
    scrollController.addListener(() {
      /*double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = 200.0;
      int index = controller.notes?["titles"].length;
      if (maxScroll - currentScroll <= delta && isInserted) {
        controller
            .loadMoreNotes(controller.notes?["titles"].length,
            MediaQuery.of(context).size.height ~/ 30)
            .then((_) => {insertNote(index)});
        isInserted = false;
      }*/
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
            child: CustomCenter(
              padding: EdgeInsets.symmetric(vertical: size.height / 8),
              child: Column(
                children: <Widget>[
                  CustomCenter(
                    padding: EdgeInsets.symmetric(
                        vertical: mediumMargin, horizontal: mediumMargin),
                    child: Text(
                      AppLocalizations.of(context)!.listArticleTitle,
                      style: GoogleFonts.montserrat(
                          fontSize: largeTextSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                  AnimatedList(
                    controller: scrollController,
                    key: listKey,
                    shrinkWrap: true,
                    initialItemCount: list["titles"]?.length ?? 0,
                    itemBuilder: (context, index, animation) {
                      return ListBuilder(position: index, animation: animation, list: list, scrollController: scrollController, onDelete: () => removeArticle(index));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
