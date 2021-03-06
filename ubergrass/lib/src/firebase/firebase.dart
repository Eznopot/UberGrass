import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebasePackage {
  static late FirebaseApp _app;
  static late FirebaseFirestore _db;
  static late FirebaseAuth _auth;
  static late FirebaseFunctions _cloudFunction;

  static void init(FirebaseApp app) {
    _app = app;
    _db = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _cloudFunction = FirebaseFunctions.instance;
  }

  static FirebaseApp getApp() {
    return _app;
  }

  static FirebaseFirestore getDB() {
    return _db;
  }

  static FirebaseAuth getAuth() {
    return _auth;
  }

  static FirebaseFunctions getFunction() {
    return _cloudFunction;
  }

}
