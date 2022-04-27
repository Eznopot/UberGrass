import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitWillPop extends StatefulWidget {
  const ExitWillPop({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  _ExitWillPopState createState() => _ExitWillPopState();
}

class _ExitWillPopState extends State<ExitWillPop> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => {
              if (Platform.isAndroid)
                {SystemNavigator.pop()}
              else if (Platform.isIOS)
                {exit(0)}
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: widget.child, onWillPop: _onWillPop);
  }
}
