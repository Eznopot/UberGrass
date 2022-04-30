import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';

import '../../firebase/firebase.dart';
import 'complete_information_service.dart';

class CompleteInformationController {
  CompleteInformationService service = CompleteInformationService();

  Future<int> updateInformations(String email, String name, String role, String city, String address) async {
    return await service.completeUserInformations(email, name, role, city, address);
  }

  Future<List<String>?> getCities() async {
    return await service.getCities();
  }

  Future<List<String>?> getRoles() async {
    return await service.getRoles();
  }
}