import 'package:cloud_functions/cloud_functions.dart';

import '../../firebase/firebase.dart';

class DeliveryPageService {

  Future<dynamic> getOrder() async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("getOrdered");
    final response = await callable();
    if (response.data == null || response.data.length == 0) {
      return null;
    }
    return response.data;
  }

  Future<bool> deleteOrder(String id) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("removeOrder");
    final response = await callable.call({
      "id": id,
    });
    print(response.data);
    return true;
  }
}