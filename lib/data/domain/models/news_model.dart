class NewsModel {
  final String link;
  final String title;
  final DateTime pubDate;
  final String description;
  final String thumbnail;

  NewsModel({
    required this.link,
    required this.title,
    required this.pubDate,
    required this.description,
    required this.thumbnail,
  });

  // fromJson constructor
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      link: json['link'] as String,
      title: json['title'] as String,
      pubDate: DateTime.parse(json['pubDate']),
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'link': link,
      'title': title,
      'pubDate': pubDate.toIso8601String(),
      'description': description,
      'thumbnail': thumbnail,
    };
  }
}
