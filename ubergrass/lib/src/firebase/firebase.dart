import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebasePackage {
  static late FirebaseApp _app;
  static late FirebaseFirestore _db;

  static void init(FirebaseApp app) {
    _app = app;
    _db = FirebaseFirestore.instance;
  }

  static FirebaseApp getApp() {
    return _app;
  }

  static FirebaseFirestore getDB() {
    return _db;
  }
}
