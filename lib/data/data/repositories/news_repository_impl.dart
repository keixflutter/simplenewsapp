import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:simplenewsapp/data/domain/models/news_model.dart';
import 'package:simplenewsapp/data/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final Dio dio;

  NewsRepositoryImpl({required this.dio});
  @override
  Future<Either<String, List<String>>> getCategories() async {
    try {
      final response =
          await dio.get('https://api-berita-indonesia.vercel.app/');
      return Right(List<String>.from(
          (response.data['endpoints'][0]['paths'] as List)
              .map((e) => e['name'])
              .toList()));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NewsModel>>> getNews(String category) async {
    try {
      final response = await dio
          .get('https://api-berita-indonesia.vercel.app/antara/$category/');
      return Right((response.data['data']['posts'] as List)
          .map((e) => NewsModel.fromJson(e))
          .toList());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
