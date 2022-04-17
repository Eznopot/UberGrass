import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSimpleButton extends StatelessWidget {
  const CustomSimpleButton({
    Key? key,
    required this.child,
    required this.onPress,
    this.backgroundColor,
    this.height,
    this.width,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPress;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        color: backgroundColor ?? Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(29.0),
          ),
        ),
        child: SizedBox(
          width: width,
          height: height ?? 48,
          child: InkWell(
            onTap: onPress,
            child: Center(
              child: child,
            ),
          ),
        ));
  }
}
