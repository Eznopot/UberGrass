import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../components/rounded_button.dart';
import '../../../components/roll_button.dart';
import '/components/rounded_field.dart';
import '../api/firebase_take_file.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../accueil/cardProd.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  @override
  const Profil({
    Key? key,
    required this.logList,
  }) : super(key: key);
  State<Profil> createState() => _ProfilState(
        this.logList,
      );
  final Map logList;
}

class _ProfilState extends State<Profil> {
  final List<Map> myProducts =
      List.generate(120, (index) => {"id": index, "name": "Product $index"})
          .toList();
  @override
  dynamic jsonList = [];

  Map logList = {};
  Future<void> takeListWidget() async {
    var client = http.Client();
    try {
      var url =
          "https://us-central1-yomy-cfc3f.cloudfunctions.net/productManageFit-user/SSrEmhqD8XHRBzUPRnh3/";
      var response = await http.get(
        Uri.parse(url),
      );
      var jsonTmp = json.decode(response.body);

      for (int i = 0; i < jsonTmp.length; i++) {
        if (logList["MAIL"] != jsonTmp[i]["id"]) jsonTmp.removeAt(i);
      }

      setState(() {
        jsonList = jsonTmp;
      });
    } finally {
      client.close();
    }
  }

  _ProfilState(this.logList) {
    takeListWidget();
  }
  final ImagePicker _picker = ImagePicker();
  File photo = File("null");
  int isPhoto = 0;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Container(
        //   margin: EdgeInsets.all(20),
        //   child: Text(
        //     "Jane Gonzales",
        //     style: TextStyle(fontSize: 25),
        //   ),
        // ),
        SizedBox(height: size.height * 0.05),

        InkWell(
          child: Container(
            height: 100,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: isPhoto == 1
                ? ClipOval(
                    child: (Image.file(photo)),
                  )
                : Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
          ),
          onTap: () async {
            final pickedFile =
                await _picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null)
              setState(() {
                photo = File(pickedFile.path);
                isPhoto = 1;
              });
          },
        ),
        Container(
          margin: EdgeInsets.only(left: 10, top: 20),
          alignment: Alignment.center,
          child: Text(
            logList["FIRSTNAME"] + " " + logList["NAME"],
            style: TextStyle(fontSize: 35),
            //    textAlign: TextAlign.right,
          ),
        ),
        SizedBox(height: size.height * 0.05),
        //           //decoration: BoxDecoration(border: Border.all(color: Colors.black)),

//         Container(
//           // margin: EdgeInsets.only(left: 9),
// //          margin: EdgeInsets.symmetric(vertical: 20),
//           child: Text(
//             "Edit Profile",
//             style: TextStyle(
//                 color: Color.fromARGB(255, 255, 255, 255),
//                 fontWeight: FontWeight.bold),
//           ),
//           color: Colors.black,
//           padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),

//           //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//           width: size.width * 0.6,
//         ),

        Container(
          margin: EdgeInsets.only(left: 9),
          alignment: Alignment.center,
//          margin: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "My products",
            style: TextStyle(
              color: Color.fromARGB(255, 9, 9, 9),
              fontSize: 25,
              // decoration: TextDecoration.underline, //make underline
              // fontWeight: FontWeight.bold
            ),
          ),
          // color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),

          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: size.width * 0.8,
        ),
        Flexible(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: jsonList.length,
              itemBuilder: (BuildContext ctx, index) {
                return ProductCard(
                  data: jsonList[index],
                  index: index,
                );
              }),
          //  Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Container(
          //       margin: EdgeInsets.all(20),
          //       child: Text(
          //         "Nike Store",
          //         style: TextStyle(fontSize: 35),
          //       ),
          //     ),
          //     Container(
          //       margin: const EdgeInsets.only(left: 20.0),
          //       child: RoundedField(
          //         hintText: "T-shirt...",
          //         onChanged: (value) {
          //           setState(() {
          //             var fde = value;
          //           });
          //         },
          //       ),
          //     ),
          //     Container(
          //       margin: EdgeInsets.all(20),
          //       child: Text(
          //         "Products",
          //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ],
          // ),

          // Expanded(
          //   flex: 5,
          //   child: Column(
          //     children: [
          //       //RecentFiles(),
          //       //if (Responsive.isMobile(context))
          //       //  SizedBox(height: defaultPadding),
          //       //TODO: RAJOJOUTER UN bouton scan de code barre

          //       //if (Responsive.isMobile(context)) StarageDetails(),
          //     ],
          //   ),
          // ),
          // if (!Responsive.isMobile(context))
          //   SizedBox(width: defaultPadding),
          // // On Mobile means if the screen is less than 850 we dont want to show it
          // if (!Responsive.isMobile(context))
          //   Expanded(
          //     flex: 2,
          //     child: StarageDetails(),
          //   ),
        ),
      ],
    );
  }
}
