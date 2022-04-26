import 'package:fithompro/Screens/addProduct/addProduct.dart';
import '../../components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedBackPageState();
  }
}

class _FeedBackPageState extends State<FeedBackPage> {
  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  int i = 0;
  String categorie = "Categorie";
  TextEditingController categorieController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    categorieController.dispose();
    subjectController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Contact"),
      ),
      body: Form(
        key: _formKey,
        onChanged: (() {
          setState(() {
            _enableBtn = _formKey.currentState!.validate();
          });
        }),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 50.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Text(
                  "Send us a feedback of your problem\nChoose a subject and write a message",
                ),
              ),
              SizedBox(height: 60.0),
              ExpansionTile(
                title: Text(
                  "Subject",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  ExpansionTile(
                    title: Text(
                      'Account',
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text('Modification'),
                        onTap: () => {
                          setState(() {
                            ;
                            categorie = "Modification";
                          })
                        },
                      ),
                      ListTile(
                        title: Text('My infos are not right'),
                        onTap: () => {
                          setState(() {
                            categorie = "My infos are not right";
                          })
                        },
                      ),
                      ListTile(
                        title: Text('Other'),
                        onTap: () => {
                          setState(() {
                            categorie = "Account : Other";
                          })
                        },
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Uploading clothes',
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text('Upload problem'),
                        onTap: () => {
                          setState(() {
                            categorie = "Upload problem";
                          })
                        },
                      ),
                      ListTile(
                        title: Text('Previsualisation do not work'),
                        onTap: () => {
                          setState(() {
                            categorie = "Previsualisation do not work";
                          })
                        },
                      ),
                      ListTile(
                        title: Text('Other'),
                        onTap: () => {
                          setState(() {
                            categorie = "Uploading clothes : Other";
                          })
                        },
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      '3d visualisation',
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text('Can not see model'),
                        onTap: () => {
                          setState(() {
                            categorie = "Can not see model";
                          })
                        },
                      ),
                      ListTile(
                        title: Text('Other'),
                        onTap: () => {
                          setState(() {
                            categorie = "3d visualisation : Other";
                          })
                        },
                      )
                    ],
                  ),
                ],
              ),
              Column(children: [
                SizedBox(height: 80.0),
                Text(
                  '$categorie',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ]),
              TextFields(
                  controller: messageController,
                  name: "Message for our team",
                  validator: ((value) {
                    if (value!.isEmpty) {
                      _enableBtn = true;
                      return 'Please enter a message to our team.';
                    }
                  }),
                  type: TextInputType.multiline),
              Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5);
                            } else if (states
                                .contains(MaterialState.disabled)) {
                              return Color.fromARGB(255, 194, 192, 192);
                            }
                            return Colors.black;
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ))),
                    onPressed: _enableBtn
                        ? (() async {
                            final Email email = Email(
                              body: messageController.text,
                              subject: '$categorie',
                              recipients: ['victor.thomas860@gmail.com'],
                              isHTML: false,
                            );
                            String platformResponse;
                            try {
                              await FlutterEmailSender.send(email);
                              platformResponse = 'success';
                            } catch (error) {
                              platformResponse = error.toString();
                            }
                            AlertDialog alert = AlertDialog(
                              title: Text("$categorie"),
                              content: Icon(Icons.mail_outline),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          })
                        : null,
                    child: const Text('Send feedback'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
