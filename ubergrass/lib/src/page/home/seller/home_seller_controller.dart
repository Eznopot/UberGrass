

import 'home_seller_service.dart';

class HomeSellerController {
  HomeSellerService service = HomeSellerService();

  Future<List<dynamic>?> getArticles(int start, int end) async {
    return await service.getArticles(start, end);
  }
}