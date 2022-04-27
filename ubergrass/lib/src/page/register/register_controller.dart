import 'package:flutter/cupertino.dart';
import 'register_service.dart';

class RegisterController with ChangeNotifier {
  RegisterService service = RegisterService();

  bool _connected = false;
  bool get connected => _connected;


  Future<bool> userCompleted() async {
    return await service.userCompleted();
  }

  Future<void> createUser(String phoneNumber, BuildContext context) async {
    await service.createUser(phoneNumber, context);
    service.addListener(() {
      _connected = service.connected;
      notifyListeners();
    });
  }
}