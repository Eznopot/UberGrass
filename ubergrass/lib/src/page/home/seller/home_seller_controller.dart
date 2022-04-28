

import 'home_seller_service.dart';

class HomeSellerController {
  HomeSellerService service = HomeSellerService();

  Future<void> getArticles(int start, int end) async {
    await service.getArticles(start, end);
  }
}