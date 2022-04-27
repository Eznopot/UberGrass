import 'package:flutter/material.dart';

import '../dialog/loading_dialog.dart';
import 'list_element.dart';

class ListBuilder extends StatelessWidget {
  ListBuilder(
      {Key? key,
      required this.list,
      required this.animation,
      required this.scrollController,
      required this.position,
      this.onDelete,
      this.onPressed
      })
      : super(key: key);
  int position;
  Map<String, List<String>?> list;
  Animation<double> animation;
  final ScrollController scrollController;
  VoidCallback? onDelete;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: ListElement(
        list: list,
        maxChar: 20,
        scrollController: scrollController,
        position: position,
        onPressDelete: onDelete ?? () {},
        onPressCard: onPressed ?? () {},
      ),
    );
  }
}
