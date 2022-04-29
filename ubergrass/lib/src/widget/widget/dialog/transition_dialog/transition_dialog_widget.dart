import 'package:flutter/material.dart';
import 'package:ubergrass/src/widget/widget/dialog/transition_dialog/transition_dialog_controller.dart';

class TransitionDialog extends StatefulWidget {
  const TransitionDialog({
    Key? key,
    this.title,
    required this.nextPage
  }) : super(key: key);
  final String? title;
  final String nextPage;

  @override
  State<TransitionDialog> createState() => _TransitionDialog();
}


class _TransitionDialog extends State<TransitionDialog> {
  final TransitionDialogController controller = TransitionDialogController();

  @override void initState() {
    super.initState();
    controller.getNextPage(widget.nextPage).then((value) {
      Navigator.pop(context, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
      false,
      child: AlertDialog(
          title: Center(child: Text(widget.title ?? 'Loading')),
          content: Wrap(
            children: const [
              Center(child: CircularProgressIndicator()),
            ],
          )),
    );
  }
}
