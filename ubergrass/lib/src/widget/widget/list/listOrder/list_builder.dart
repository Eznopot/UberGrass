import 'package:flutter/material.dart';

import 'list_element.dart';

class ListBuilderOrder extends StatelessWidget {
  ListBuilderOrder(
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
  List<dynamic> list;
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
      child: ListElementOrder(
        map: list[position]["data"],
        maxChar: 20,
        scrollController: scrollController,
        position: position,
        onPressDelete: onDelete ?? () {},
        onPressCard: onPressed ?? () {},
      ),
    );
  }
}
