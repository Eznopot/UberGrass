

import 'home_delivery_service.dart';

class HomeDeliveryController {
  HomeDeliveryService service = HomeDeliveryService();

  Future<List<dynamic>?> getOrders(int start, int end) async {
    return await service.getOrders(start, end);
  }

  Future<bool> acceptOrder(String id) async {
    return await service.acceptOrder(id);
  }
}