import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firebase/firebase.dart';

class UserData {
  static UserData? _instance;
  UserCredential? _userData;

  UserData._internal();

  factory UserData() => _instance ??= UserData._internal();

  void addUserToGroup() async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    function.httpsCallable("addUserToRoles");
    HttpsCallable callable = function.httpsCallable("addUserToRoles");
    final resp = await callable.call({
      'uid' : _userData!.user!.uid,
    });
    print(resp);
  }

  void setUserData(UserCredential userData) {
    _userData = userData;
  }

  void updateEmail(String email) {
    if (_userData != null) {
      _userData!.user!.updateEmail(email);
    }
  }

  void updateName(String name) {
    if (_userData != null) {
      _userData!.user!.updateDisplayName(name);
    }
  }
}