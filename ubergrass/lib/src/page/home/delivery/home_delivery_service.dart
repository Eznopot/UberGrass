import 'package:cloud_functions/cloud_functions.dart';
import 'package:ubergrass/src/firebase/firebase.dart';

class HomeDeliveryService {
  Future<List<dynamic>?> getOrders(int start, int end) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("getOrderInGroup");
    final response = await callable.call({
      "start" : start, 
      "end" : end,
    });
    if (response.data == null || response.data.length == 0) {
      return null;
    }
    return response.data;
  }

  Future<bool> acceptOrder(String id) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    HttpsCallable callable = function.httpsCallable("acceptOrder");
    print(id);
    final response = await callable.call({
      "id": id
    });
    if (response.data == false) {
      return false;
    }
    return true;
  }
}