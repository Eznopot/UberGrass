import 'package:cloud_functions/cloud_functions.dart';
import 'package:ubergrass/src/firebase/firebase.dart';

class HomeSellerService {
  Future<void> getArticles(int start, int end) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("getArticles");
    dynamic response = await callable.call({
      "start" : start, 
      "end" : end,
    });
    print(response.data);
  }
}