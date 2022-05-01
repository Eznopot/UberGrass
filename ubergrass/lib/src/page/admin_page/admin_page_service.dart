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

  Future<List<dynamic>?> GetAllCollections() async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    var httpsCallable = function.httpsCallable("GetAllCollection");
    final response = await httpsCallable.call();
    if (response.data == null || response.data.length == 0) {
      return null;
    }
    List<dynamic> res = [];
    for (dynamic elem in response.data) {
      res.add({"id" : elem["id"]});
    }
    return res;
  }

  Future<List<dynamic>?> GetRefDocOfCollections(String DocName) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    var httpsCallable = function.httpsCallable("GetAllDocOfCollection");
    final response = await httpsCallable.call({"docName": DocName,});
    if (response.data == null || response.data.length == 0) {
      return null;
    }
    List<dynamic> res = [];
    for (dynamic elem in response.data) {
      res.add({"id" : elem["id"]});
    }
    return res;
  }

  Future<dynamic> GetDocFromCall(String callName, String docName) async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    var httpsCallable = function.httpsCallable("GetDocFromCall");
    final response = await httpsCallable.call({"docName": docName, "callName": callName,});
    if (response.data == null) {
      return null;
    }
    return response.data;
  }
}