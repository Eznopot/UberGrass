import 'package:flutter/material.dart';
import '/Screens/Login/login_screen.dart';
import '/Screens/Signup/components/background.dart';
import '/Screens/Signup/components/or_divider.dart';
import '/Screens/Signup/components/social_icon.dart';
import '/components/already_have_an_account_acheck.dart';
import '/components/rounded_button.dart';
import '/components/rounded_input_field.dart';
import '/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import '../../appMenu/menu.dart';

import '../signup_screen.dart';

class Body extends StatefulWidget {
  var newStatus;
  var errorMsg;
  @override
  Body(this.newStatus, this.errorMsg);

  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  var mail = "";
  var mdp = "";
  var name = "";
  var firstname = "";
  var boutique = "";

  Widget build(BuildContext context) {
    // GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

    // loginGoogle() async {
    //   try {
    //     await _googleSignIn.signIn();
    //   } catch (err) {
    //     print(err);
    //   }
    // }

    // Future<void> signGoogle(var emailGoogle) async {
    //   var client = http.Client();
    //   try {
    //     var url = "http://10.0.2.2:8000/create_account";
    //     var response = await http.post(url, body: {
    //       'email': emailGoogle,
    //       'password': "google",
    //     });
    //     setState(
    //       () {
    //         if (response.statusCode == 201) {
    //           this.newStatus = 1;
    //         } else
    //           this.newStatus = -1;
    //       },
    //     );
    //     newError = response.body;
    //   } finally {
    //     client.close();
    //   }
    // }

    int statusLog = 0;
    Future<void> sendAccount() async {
      var client = http.Client();
      //  Map data = takeData();
      Map data = {
        "MAIL": mail,
        "MDP": mdp,
        "NAME": name,
        "FIRSTNAME": firstname,
        "BOUTIQUE": boutique,
      };

      setState(() {
        if (mail == "" ||
            mdp == "" ||
            name == "" ||
            firstname == "" ||
            boutique == "") {
          statusLog = -1;
        } else
          statusLog = 1;
      });
      // print(data);
      try {
        var url =
            "https://us-central1-yomy-cfc3f.cloudfunctions.net/compte-user/SSrEmhqD8XHRBzUPRnh3";
        var response = await http.post(Uri.parse(url), body: data);
        print(response.body);

        //var jsonList = json.decode(response.body);

      } catch (e) {}
    }

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.16),
            SizedBox(
              width: 310,
              child: Container(
                child: Text(
                  "SIGNUP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                setState(() {
                  mail = value;
                  print(mail);
                });
              },
            ),
            RoundedInputField(
              hintText: "Your first name",
              onChanged: (value) {
                setState(() {
                  firstname = value;
                  print(mail);
                });
              },
            ),
            RoundedInputField(
              hintText: "Your name",
              onChanged: (value) {
                setState(() {
                  name = value;
                  print(mail);
                });
              },
            ),
            RoundedInputField(
              hintText: "Your shop's name",
              onChanged: (value) {
                setState(() {
                  boutique = value;
                  print(mail);
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  mdp = value;
                  print(mdp);
                });
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                print(mail);

                sendAccount();
                var data = {
                  "MDP": mdp,
                  "MAIL": mail,
                  "NAME": name,
                  "FIRSTNAME": firstname,
                  "BOUTIQUE": boutique,
                };
                // if (signStatus == 1) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) {
                //       return MenuBurger(jsonList[indexList]);
                //     }),
                //   );
                // }
                if (statusLog == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MenuBurger(data);
                    }),
                  );
                }
                // await login();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       if (newStatus == 1) {
                //         return LoginScreen(0);
                //       } else
                //         return SignUpScreen(
                //           -1,
                //           newError,
                //         );
                //     },
                //   ),
                // );
              },
            ),
            SizedBox(height: size.height * 0.01),
            RoundedButton(
              text: "LOG IN WITH GOOGLE",
              press: () {},
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen(0);
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
