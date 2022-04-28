import 'package:cloud_functions/cloud_functions.dart';
import 'package:ubergrass/src/firebase/firebase.dart';

class TransitionDialogService  {

  Future<String> getNextPage(String route) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    return "/home_page";
  }

}