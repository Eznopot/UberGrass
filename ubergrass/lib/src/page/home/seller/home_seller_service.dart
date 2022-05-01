import 'package:cloud_functions/cloud_functions.dart';
import 'package:ubergrass/src/firebase/firebase.dart';

class HomeSellerService {
  Future<List<dynamic>?> getArticles(int start, int end) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("getArticles");
    final response = await callable.call({
      "start" : start, 
      "end" : end,
    });
    if (response.data == null || response.data.length == 0) {
      return null;
    }
    List<dynamic> res = [];
    for (dynamic elem in response.data) {
      res.add({"data" : elem["data"], "id" : elem["id"]});
    }
    return res;
  }

  Future<bool> removeArticles(String id) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("removeArticle");
    final response = await callable.call({
      "id" : id,
    });
    return true;
  }
}