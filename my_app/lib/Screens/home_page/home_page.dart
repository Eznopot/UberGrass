import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage();

  @override
  State<StatefulWidget> createState() {
    return _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 50.0,
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
        ),

        Container(
          margin: const EdgeInsets.only(top: 190.0),
          alignment: Alignment.center,
          child: const Text(
            "Welcome to\nFitting home pro",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 36),
          ),
        ),
        // Expanded(child: Container()),
        Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 200.0),
          child: const Text(
            "You registered in\n the space",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }
}
