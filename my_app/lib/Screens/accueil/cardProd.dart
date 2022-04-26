import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../constants.dart';
import '../api/firebase_take_file.dart';
import 'prodScreen.dart';

List cardTitle = [
  "Chiffre d'affaire",
  "Benefices",
  "Objets vendus",
  "Commandes livrées",
];

List logoTitle = [
  "assets/icons/Documents.svg",
  "assets/icons/google_drive.svg",
  "assets/icons/one_drive.svg",
  "assets/icons/drop_box.svg",
];

List vetement = [
  "assets/images/foulard.png",
  "assets/images/sweat.png",
  "assets/images/jean.png",
  "assets/images/jean.png",
  "assets/images/jean.png",
  "assets/images/jean.png",
  "assets/images/jean.png",
  "assets/images/jean.png",
];

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final Map<Object, dynamic> data;
  final int index;
  @override
  _ProductCardState createState() => _ProductCardState(
        data,
        index,
      );
}

class _ProductCardState extends State<ProductCard> {
  late Map<Object, dynamic> data;
  int index;
  _ProductCardState(this.data, this.index) {
    // print(data);
  }

  int saveIndex = 0;
  Future<void> takePhoto() async {
    futureFiles = FirebaseApi.listAll(
        "SSrEmhqD8XHRBzUPRnh3/photo/" + data["id"] + "/" + data["NOM"]);
  }

  void initState() {
    super.initState();
    takePhoto();
  }

  late Future<List<FirebaseFile>> futureFiles;

  String parseCat(List<dynamic> catData) {
    String res = "";
    for (int i = 0; i != catData.length; i++) {
      res = res + catData[i] + "/";
    }
    res = res.substring(0, res.length - 1);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<List<FirebaseFile>>(
      future: futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(child: Text('Some error occurred!'));
            } else {
              final files = snapshot.data!;

//  Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => AddProduct(
//                                         refreshFunction: refreshFunction,
//                                         idShop: idShop,
//                                       )));
              return Card(
                elevation: 7,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProdScreen(
                                  index: index,
                                  productName: data["NOM"],
                                )));
                    print("dsdsq");
                  },
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 150.0,
                        width: 150.0,
                        padding: EdgeInsets.all(4),
                        child: Image.network(files[0].url),
                      ),
                      Container(
                        //alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20),
                        child: Text(data["NOM"]),
                      ),
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
