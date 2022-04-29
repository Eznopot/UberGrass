import 'package:cloud_functions/cloud_functions.dart';

import '../../firebase/firebase.dart';

class ArticleVisualisationService {
  Future<bool> buyArticle(int quantity, String id) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("buyArticles");
    await callable.call({
      "quantity": quantity,
      "id" : id
    });
    return true;
  }
}