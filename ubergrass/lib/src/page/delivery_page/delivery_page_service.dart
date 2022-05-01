import 'package:cloud_functions/cloud_functions.dart';

import '../../firebase/firebase.dart';

class DeliveryPageService {

  Future<dynamic> getOrder() async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("getOrdered");
    final response = await callable();
    print(response.data);
    if (response.data == null || response.data.length == 0) {
      return null;
    }
    return response.data;
  }

  Future<bool> deleteOrder(String id) async {
    return true;
  }
}