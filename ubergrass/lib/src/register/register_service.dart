import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ubergrass/src/model/user_data.dart';

import '../firebase/firebase.dart';

class RegisterService with ChangeNotifier {
  bool _connected = false;
  bool get connected => _connected;


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
                Navigator.of(context).pop();
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
  }

  Future<void> createUser(String phoneNumber, BuildContext context) async {
    FirebaseAuth _auth = FirebasePackage.getAuth();
    try {
      if (kIsWeb) {
        final confirmationResult =
        await _auth.signInWithPhoneNumber(phoneNumber);
        final smsCode = await getSmsCodeFromUser(context);
        if (smsCode != null) {
          await confirmationResult.confirm(smsCode);
        }
      } else {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(minutes: 2),
          verificationCompleted: (credential) {
            _auth.signInWithCredential(credential).then((value) {
              print("test");
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
                  _connected = true;
                  notifyListeners();
                }).onError((error, stackTrace) {
                  notifyListeners();
                });
              } on FirebaseAuthException catch (e) {
                notifyListeners();
                print(e);
              }
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