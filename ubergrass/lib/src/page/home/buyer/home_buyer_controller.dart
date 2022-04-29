

import 'home_buyer_service.dart';

class HomeBuyerController {
  HomeBuyerService service = HomeBuyerService();

  Future<List<dynamic>?> getArticles(int start, int end) async {
    return await service.getArticles(start, end);
  }
}