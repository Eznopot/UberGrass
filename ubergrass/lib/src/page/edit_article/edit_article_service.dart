import 'package:cloud_functions/cloud_functions.dart';

import '../../firebase/firebase.dart';

class EditArticleService {
  Future<bool> editArticle(String name, double price, int quantity, double weight, String id) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("modifyArticles");
    await callable.call({
      "name": name,
      "price": price,
      "quantity": quantity,
      "weight": weight,
      "id" : id
    });
    return true;
  }
}