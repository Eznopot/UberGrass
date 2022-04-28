import 'create_article_dialog_service.dart';

class CreateArticleDialogController  {
  CreateArticleDialogService service = CreateArticleDialogService();

  Future<bool> createArticle(String title, double price, int quantity, double weight) async {
    return await service.createArticle(title, price, quantity, weight);
  }


}