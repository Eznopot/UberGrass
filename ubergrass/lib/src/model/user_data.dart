import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  static UserData? _instance;
  UserCredential? _userData;

  UserData._internal();

  factory UserData() => _instance ??= UserData._internal();

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