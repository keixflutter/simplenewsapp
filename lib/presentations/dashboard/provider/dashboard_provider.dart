import 'package:flutter/material.dart';
import 'package:simplenewsapp/data/domain/models/news_model.dart';
import 'package:simplenewsapp/data/domain/repositories/news_repository.dart';

class DashboardProvider extends ChangeNotifier {
  final NewsRepository repository;
  DashboardProvider({required this.repository});

  ///states
  Map<String, List<NewsModel>> news = {};
  bool isLoading = false;
  String? message;
  List<String> categories = [];
  String? selectedCategory;

  ///methods
  List<NewsModel> newsByCategory(String? category) {
    if (category == null) return [];
    return news[category] ?? [];
  }

  getNews(String category) async {
    selectedCategory = category;
    toggleLoading(true);
    final response = await repository.getNews(category);
    toggleLoading(false);
    response.fold(
      (l) {
        message = l;
      },
      (r) {
        news[category] = r;
      },
    );
    notifyListeners();
  }

  Future getCategories() async {
    toggleLoading(true);
    final response = await repository.getCategories();
    toggleLoading(false);
    response.fold(
      (l) {
        message = l;
      },
      (r) {
        categories = r;
      },
    );
    notifyListeners();
    return null;
  }

  toggleLoading(bool value) {
    isLoading = value;
    message = null;
    notifyListeners();
  }
}
