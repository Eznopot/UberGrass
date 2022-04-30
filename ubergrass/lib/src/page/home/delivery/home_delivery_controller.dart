

import 'home_delivery_service.dart';

class HomeDeliveryController {
  HomeDeliveryService service = HomeDeliveryService();

  Future<List<dynamic>?> getArticles(int start, int end) async {
    return await service.getArticles(start, end);
  }
}