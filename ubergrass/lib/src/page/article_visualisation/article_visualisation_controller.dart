import 'article_visualisation_service.dart';

class ArticleVisualisationController {
  ArticleVisualisationService service = ArticleVisualisationService();


  Future<bool>buyArticle(String id, int quantity) async {
    return await service.buyArticle(quantity, id);
  }
}