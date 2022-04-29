import 'package:ubergrass/src/page/edit_article/edit_article_service.dart';

class EditArticleController {
  EditArticleService service = EditArticleService();


  Future<bool>editArticle(String name, double price, int quantity, double weight, String id) async {
    return await service.editArticle(name, price, quantity, weight, id);
  }
}