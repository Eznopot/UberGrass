import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../components/rounded_button.dart';
import '../../../components/roll_button.dart';
import '/components/rounded_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cardProd.dart';

class Accueil extends StatefulWidget {
  @override
  const Accueil({
    Key? key,
    required this.logList,
  }) : super(key: key);
  final Map logList;
  State<Accueil> createState() => _AccueilState(logList);
}

class _AccueilState extends State<Accueil> {
  final List<Map> myProducts =
      List.generate(120, (index) => {"id": index, "name": "Product $index"})
          .toList();
  @override
  _AccueilState(this.logList) {
    takeListWidget();
  }
  final Map logList;

  dynamic jsonList = [];
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

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 150, top: 60),
          child: Text(
            logList["BOUTIQUE"],
            style: TextStyle(fontSize: 35),
            //    textAlign: TextAlign.right,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10.0, top: 20),
          child: RoundedField(
            hintText: "T-shirt, pants ...",
            onChanged: (value) {
              setState(() {
                //      var fde = value;
              });
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10.0, top: 20),
          child: Text(
            "PRODUCTS",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
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
