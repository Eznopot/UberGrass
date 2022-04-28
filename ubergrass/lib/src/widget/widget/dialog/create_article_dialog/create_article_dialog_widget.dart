import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../textfield/custom_text_field.dart';
import 'create_article_dialog_controller.dart';

class CreateArticleDialog extends StatefulWidget {
  const CreateArticleDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateArticleDialog> createState() => _CreateArticleDialog();
}

class _CreateArticleDialog extends State<CreateArticleDialog> {
  final CreateArticleDialogController controller =
      CreateArticleDialogController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  bool requestSend = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: AlertDialog(
        title: Center(child: Text("Create article")),
        content: Wrap(
            children: requestSend == true
                ? <Widget>[const Center(child: CircularProgressIndicator())]
                : <Widget>[]),
        actions: requestSend == false
            ? <Widget>[
                CustomTextField(
                  labelText:
                      AppLocalizations.of(context)!.dialogCreateArticleTitle,
                  controller: titleController,
                ),
                CustomTextField(
                  labelText:
                      AppLocalizations.of(context)!.dialogCreateArticlePrice,
                  textInputType: TextInputType.number,
                  controller: priceController,
                ),
                CustomTextField(
                  textInputType: TextInputType.number,
                  labelText:
                      AppLocalizations.of(context)!.dialogCreateArticleQuantity,
                  controller: quantityController,
                ),
                CustomTextField(
                  textInputType: TextInputType.number,
                  labelText:
                      AppLocalizations.of(context)!.dialogCreateArticleWeight,
                  controller: weightController,
                ),
                TextButton(
                  onPressed: () => {
                    if (titleController.text.isNotEmpty &&
                        double.parse(priceController.text) > 0 &&
                        int.parse(quantityController.text) > 0 &&
                        double.parse(weightController.text) > 0)
                      {
                        setState(() {
                          requestSend = true;
                        }),
                        controller
                            .createArticle(
                                titleController.text,
                                double.parse(priceController.text),
                                int.parse(quantityController.text),
                                double.parse(weightController.text))
                            .then((value) {
                          if (value) {
                            Navigator.pop(context, true);
                          } else {
                            setState(() {
                              requestSend = false;
                            });
                          }
                        })
                      }
                  },
                  child: const Text('Create'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
              ]
            : [],
      ),
    );
  }
}
