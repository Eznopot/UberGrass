import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase/firebase.dart';
import '../model/users.dart';

class RegisterService {
  Future<int> createUser(Users user) async {
    FirebaseFirestore db = FirebasePackage.getDB();
    await db.collection("Users").add(user.toJson());
    return 0;
  }
}