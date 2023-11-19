import 'package:dartz/dartz.dart';
import 'package:simplenewsapp/data/domain/models/news_model.dart';

abstract class NewsRepository {
  Future<Either<String, List<String>>> getCategories();
  Future<Either<String, List<NewsModel>>> getNews(String category);
}
