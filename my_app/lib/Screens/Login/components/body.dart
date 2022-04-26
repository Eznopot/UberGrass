import 'package:flutter/material.dart';
import '/Screens/Login/components/background.dart';
import '/Screens/Signup/signup_screen.dart';
import '/components/already_have_an_account_acheck.dart';
import '/components/rounded_button.dart';
import '/components/rounded_input_field.dart';
import '/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../login_screen.dart';
import 'package:http/http.dart' as http;
import '../../appMenu/menu.dart';
import 'dart:convert';

class Body extends StatefulWidget {
  Body(this.newStatus);
  var newStatus;

  @override
  State<Body> createState() => _BodyState(newStatus);
}

class _BodyState extends State<Body> {
  var email;
  var password;
  var newStatus = 0;
  var saveStates;

  var lel;
  _BodyState(this.saveStates) {
    // newStatus = widget.newStatus;
  }
  @override
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  loginGoogle() async {
    try {
      print("aaaaaaaaaaaaa");

      await _googleSignIn.signIn();
    } catch (err) {
      print(err);
    }
  }

  Future<void> signupGoogle(var emailGoogle) async {
    var client = http.Client();
    try {
      var url =
          "https://us-central1-area-5269b.cloudfunctions.net/app/create_account";
      var response = await http.post(Uri.parse(url), body: {
        'email': emailGoogle,
        'password': "google",
      });
      setState(
        () {
          if (response.statusCode == 201) {
            this.email = emailGoogle;
            this.newStatus = 1;
          } else
            this.newStatus = -1;
        },
      );
    } finally {
      client.close();
    }
  }

  Future<void> signGoogle(var emailGoogle) async {
    print(_googleSignIn);
    var client = http.Client();
    print(emailGoogle);
    try {} finally {
      client.close();
    }
  }

  // Future<void> login() async {
  //   //saveStates = widget.newStatus;
  //   var client = http.Client();
  //   try {
  //     var url = "https://us-central1-area-5269b.cloudfunctions.net/app/signin";
  //     var response = await http.post(Uri.parse(url), body: {
  //       'email': email,
  //       'password': password,
  //     });
  //     setState(
  //       () {
  //         if (response.statusCode == 201) {
  //           print("lflkdlfds");
  //           lel = 1;
  //           this.newStatus = 1;
  //         } else
  //           this.newStatus = -1;
  //       },
  //     );
  //     print('Response body: ${response.body}');
  //   } finally {
  //     client.close();
  //   }
  // }

  List<dynamic> jsonList = [];

  Future<void> takeListCompte() async {
    var client = http.Client();
    try {
      var url =
          "https://us-central1-yomy-cfc3f.cloudfunctions.net/compte-user/SSrEmhqD8XHRBzUPRnh3/";
      var response = await http.get(
        Uri.parse(url),
      );
      print('Response status: ${response.statusCode}');
      // print(jsonList[0]["id"]);

      setState(() {
        jsonList = json.decode(response.body);
        print(jsonList);
        int check = 0;
        for (int i = 0; jsonList.length != i; i++) {
          if (jsonList[i]["MAIL"] == email) {
            check = 1;
            if (jsonList[i]["MDP"] == password) {
              signStatus = 1;
              indexList = i;
            } else {
              errorMessage = "Le mot de passe ne correspond pas";
              signStatus = -1;
            }
            break;
          }
        }
        if (check == 0) {
          signStatus = -1;
          errorMessage = "Aucun compte trouvé avec cette adresse mail";
        }
        //     print(jsonList);
      });
    } finally {
      client.close();
    }
  }

  int indexList = 0;
  var errorMessage = "";
  var signStatus = 0;
  int tryConnect() {
    //  login();
    print(this.newStatus);
    if (newStatus == 1) {
      return 1;
    }
    return -1;
  }

  int fillForm = 0;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: size.height * 0.16),
            SizedBox(
              width: 310,
              child: Container(
                child: Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            RoundedPasswordField(onChanged: (value) {
              setState(() {
                password = value;
              });
            }),
            if (signStatus == -1)
              Container(
                  child: Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              )),
            // fillForm == -1 ? SizedBox(height: size.height * 0.00) : Container(),
            // fillForm == -1
            //     ? //SizedBox(height: size.height * 0.03)
            //     Text(
            //         'Wrong password or email',
            //         textAlign: TextAlign.center,
            //         overflow: TextOverflow.ellipsis,
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold, color: Colors.red[300]),
            //       )
            //     : Text(""),
            RoundedButton(
              text: "LOG IN",
              press: () async {
                // //await login();
                // if (email == "tommy.simeon@hotmail.fr" ||
                //     email == "123@lol.fr") {
                //   setState(() {
                //     fillForm = -1;
                //   });
                // } else {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) {
                //       return MenuBurger();
                //     }),
                //   );
                // }

                takeListCompte();
                print(jsonList[indexList]);
                if (signStatus == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MenuBurger(jsonList[indexList]);
                    }),
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.01),
            RoundedButton(
              text: "LOG IN WITH GOOGLE",
              press: () async {
                await loginGoogle();
                print("iiiiiiiiiiiiiiiiii");

                // print(_googleSignIn.currentUser.email);
                print("iiiiiiiiiiiiiiiiii");

                // await signGoogle(_googleSignIn.currentUser.email);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      print("ddsdsqdqs");
                      return MenuBurger(jsonList[indexList]);
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen(0, "");
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
