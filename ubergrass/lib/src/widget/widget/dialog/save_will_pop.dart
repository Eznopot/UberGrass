import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveWillPop extends StatefulWidget {
  const SaveWillPop(
      {Key? key,
      required this.child,
      required this.isSaved,
      this.canLeave,
      this.onQuit,
      this.onCancel})
      : super(key: key);
  final Widget child;
  final bool isSaved;
  final VoidCallback? onQuit;
  final VoidCallback? onCancel;
  final bool? canLeave;

  @override
  _SaveWillPopState createState() => _SaveWillPopState();
}

class _SaveWillPopState extends State<SaveWillPop> {
  Future<bool> _onWillPop() async {
    if (widget.isSaved) {
      Navigator.of(context).pop(true);
      return true;
    }
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Save'),
            content: const Text('Do you want to save ?'),
            actions: <Widget>[
              TextButton(
                onPressed: widget.onCancel,
                child: const Text('No'),
              ),
              TextButton(
                onPressed: widget.onQuit,
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: widget.child,
        onWillPop: widget.canLeave == false
            ? () async {
                return false;
              }
            : _onWillPop);
  }
}
