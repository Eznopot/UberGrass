import 'package:flutter/cupertino.dart';
import 'package:ubergrass/src/register/register_service.dart';

import '../model/users.dart';

class RegisterController with ChangeNotifier {
  RegisterService service = RegisterService();

  bool _connected = false;
  bool get connected => _connected;

  Future<void> createUser(String phoneNumber, BuildContext context) async {
    await service.createUser(phoneNumber, context);
    service.addListener(() {
      _connected = service.connected;
      notifyListeners();
    });
  }
}