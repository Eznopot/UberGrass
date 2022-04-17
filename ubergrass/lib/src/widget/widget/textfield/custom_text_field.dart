import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.inputBorder,
    this.outlineInputBorder,
    this.isPassword,
    this.color,
    this.changed,
    this.textInputType
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final bool? isPassword;
  final InputBorder? inputBorder;
  final OutlineInputBorder? outlineInputBorder;
  final TextEditingController? controller;
  final Color? color;
  final TextInputType? textInputType;
  final void Function(String string)? changed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword ?? false,
      keyboardType: textInputType,
      controller: controller,
      onChanged: changed,
      decoration: InputDecoration(
        border: outlineInputBorder ?? inputBorder ?? const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        fillColor: color ?? Colors.white,
        filled: color != null ? true : false,
      ),
    );
  }
}
