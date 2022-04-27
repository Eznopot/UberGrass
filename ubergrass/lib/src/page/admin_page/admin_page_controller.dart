import 'package:flutter/cupertino.dart';
import 'admin_page_service.dart';

class AdminPageController {
  AdminPageService service = AdminPageService();

  Future<String> callCloudFunction(String functioName) async {
    return await service.callFunction(functioName);
  }
}