import 'package:flutter/cupertino.dart';
import 'package:ubergrass/src/register/register_service.dart';

import '../model/users.dart';

class RegisterController with ChangeNotifier {
  RegisterService service = RegisterService();

  Future<int> createUser(Users user) async {
    await service.createUser(user);
    return 0;
  }
}