import 'package:cloud_functions/cloud_functions.dart';
import 'package:ubergrass/src/firebase/firebase.dart';

class CreateArticleDialogService  {
  Future<bool> createArticle(String title, double price, int quantity, double weight) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("createArticles");
    dynamic response = await callable.call({
      "name": title,
      "price": price,
      "quantity": quantity,
      "weight": weight,
    });
    return true;
  }
}