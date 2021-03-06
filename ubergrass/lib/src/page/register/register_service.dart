import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ubergrass/src/model/user_data.dart';

import '../../firebase/firebase.dart';

class RegisterService with ChangeNotifier {
  bool _connected = false;
  bool get connected => _connected;

  Future<bool> userCompleted() async {
    FirebaseFunctions function = FirebasePackage.getFunction();
    var httpsCallable = function.httpsCallable("getMe");
    final response = await httpsCallable();
    if (response.data == null) {
      return false;
    }
    return response.data["Status"] == "Complete";
  }

  Future<String?> getSmsCodeFromUser(context) async {
    String? smsCode;
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('SMS code:'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(smsCode);
              },
              child: const Text('Sign in'),
            ),
            OutlinedButton(
              onPressed: () {
                smsCode = null;
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
          content: Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (value) {
                smsCode = value;
              },
              textAlign: TextAlign.center,
              autofocus: true,
            ),
          ),
        );
      },
    );
    return smsCode;
  }

  Future<void> createUser(String phoneNumber, BuildContext context) async {
    FirebaseAuth _auth = FirebasePackage.getAuth();
    try {
      if (kIsWeb) {
        final confirmationResult =
        await _auth.signInWithPhoneNumber(phoneNumber);
        final smsCode = await getSmsCodeFromUser(context);
        if (smsCode != null) {
          confirmationResult.confirm(smsCode).then((value) {
            UserData user = UserData();
            user.setUserData(value);
            _connected = true;
            notifyListeners();
          }).onError((error, stackTrace) {
            notifyListeners();
          });
        } else {
          notifyListeners();
        }
      } else {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(minutes: 2),
          verificationCompleted: (credential) {
            _auth.signInWithCredential(credential).then((value) {
              UserData user = UserData();
              user.setUserData(value);
              _connected = true;
              notifyListeners();
            }).onError((error, stackTrace) {
              notifyListeners();
            });
          },
          verificationFailed: (e) {
            notifyListeners();
            print(e);
          },
          codeSent: (String verificationId, int? resendToken) async {
            final smsCode = await getSmsCodeFromUser(context);
            if (smsCode != null) {
              final credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: smsCode,
              );
              try {
                _auth.signInWithCredential(credential).then((value) {
                  UserData user = UserData();
                  user.setUserData(value);
                  _connected = true;
                  notifyListeners();
                }).onError((error, stackTrace) {
                  notifyListeners();
                });
              } on FirebaseAuthException catch (e) {
                notifyListeners();
                print(e);
              }
            } else {
              notifyListeners();
            }
          },
          codeAutoRetrievalTimeout: (e) {
            print(e);
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }
}