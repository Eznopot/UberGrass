import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ubergrass/src/model/user_data.dart';

import '../../firebase/firebase.dart';

class AdminPageService {
  Future<String> callFunction(String functionName) async {
    UserData userData = UserData();
    FirebaseFunctions function = FirebasePackage.getFunction();
    var httpsCallable = function.httpsCallable(functionName);
    var res = await httpsCallable.call();
    return res.data.toString();
  }
}