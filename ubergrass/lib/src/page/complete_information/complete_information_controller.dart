import 'package:cloud_functions/cloud_functions.dart';

import '../../firebase/firebase.dart';
import 'complete_information_service.dart';

class CompleteInformationController {
  CompleteInformationService service = CompleteInformationService();

  void updateInformations(String email, String Name) {
    service.updateInformations(email, Name);
  }

  Future<List<String>?> getCity() async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    var httpsCallable = function.httpsCallable("getCity");
    var res = await httpsCallable.call();
    print(res.data);
    return res.data;
  }

}