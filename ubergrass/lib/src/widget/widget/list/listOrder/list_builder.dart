import 'package:flutter/material.dart';

import 'list_element.dart';

class ListBuilderOrder extends StatelessWidget {
  ListBuilderOrder(
      {Key? key,
      required this.list,
      required this.animation,
      required this.scrollController,
      required this.position,
      this.onAccept
      })
      : super(key: key);
  int position;
  List<dynamic> list;
  Animation<double> animation;
  final ScrollController scrollController;
  VoidCallback? onAccept;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: ListElementOrder(
        map: list[position],
        maxChar: 20,
        scrollController: scrollController,
        position: position,
        onAccept: onAccept ?? () {},
      ),
    );
  }
}
