import 'package:cloud_functions/cloud_functions.dart';
import 'package:ubergrass/src/firebase/firebase.dart';

class HomeBuyerService {
  Future<List<dynamic>?> getArticles(int start, int end) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("getArticlesInGroup");
    final response = await callable.call({
      "start" : start, 
      "end" : end,
    });
    print("data: " + response.data.toString());
    if (response.data == null || response.data.length == 0) {
      return null;
    }
    List<dynamic> res = [];
    for (dynamic elem in response.data) {
      res.add({"data" : elem["data"], "id" : elem["id"]});
    }
    print("lenght===>" + res.length.toString());
    return res;
  }
}