import 'package:ubergrass/src/page/delivery_page/delivery_page_service.dart';

class DeliveryPageController {
  DeliveryPageService service = DeliveryPageService();

  Future<dynamic> getOrder() async {
    return await service.getOrder();
  }

  Future<bool> deleteOrder(String id) async {
    return await service.deleteOrder(id);
  }
}