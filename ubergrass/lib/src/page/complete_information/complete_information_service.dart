import 'package:cloud_functions/cloud_functions.dart';
import 'package:ubergrass/src/model/user_data.dart';

import '../../firebase/firebase.dart';


class CompleteInformationService {
  Future<int> completeUserInformations(String email, String name, String role, String city, String address) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    var httpsCallable = function.httpsCallable("setUsers");
    var response = await httpsCallable.call({
      "rolesType" : role,
      "city" : city,
      "name" : name,
      "email" : email,
      "address" : address
    });
    if (response.data != null) {
      return 0;
    }
    return -1;
  }

  Future<List<String>?> getCities() async {
    List<String> arr = [];
    FirebaseFunctions function = FirebasePackage.getFunction();
    var httpsCallable = function.httpsCallable("getCities");
    final response = await httpsCallable();
    for (dynamic elem in response.data) {
      arr.add(elem["Name"]);
    }
    return arr;
  }

  Future<List<String>?> getRoles() async {
    List<String> arr = [];
    FirebaseFunctions function = FirebasePackage.getFunction();
    var httpsCallable = function.httpsCallable("getRoles");
    final response = await httpsCallable();
    for (dynamic elem in response.data) {
      arr.add(elem["Type"]);
    }
    return arr;
  }
}