import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simplenewsapp/data/data/repositories/news_repository_impl.dart';
import 'package:simplenewsapp/data/domain/repositories/news_repository.dart';
import 'package:simplenewsapp/presentations/dashboard/provider/dashboard_provider.dart';

var di = GetIt.I;

setupInjection() {
  di.registerFactory(() => Dio());
  di.registerFactory<NewsRepository>(() => NewsRepositoryImpl(dio: di()));
  di.registerFactory(() => DashboardProvider(repository: di()));
}
