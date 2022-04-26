import 'package:cloud_functions/cloud_functions.dart';

import '../firebase/firebase.dart';
import '../model/user_data.dart';

class CompleteInformationService {
  void updateInformations(String email, String name) {
    UserData userData = UserData();
    userData.addUserToGroup();
  }
}