import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCenter extends StatelessWidget {
  const CustomCenter({
    Key? key,
    required this.child,
    required this.padding,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
