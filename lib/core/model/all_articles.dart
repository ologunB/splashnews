class AllArticles {
  AllArticles({this.status, this.totalResults, this.articles});

  AllArticles.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String;
    totalResults = json['totalResults'] as int;
    if (json['articles'] != null) {
      articles = <Article>[];
      json['articles'].forEach((dynamic v) {
        articles.add(Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (articles != null) {
      data['articles'] = articles.map((Article v) => v.toJson()).toList();
    }
    return data;
  }

  String status;
  int totalResults;
  List<Article> articles;
}

class Article {
  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Article.fromJson(dynamic json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'] as String;
    title = json['title'] as String;
    description = json['description'] as String;
    url = json['url'] as String;
    urlToImage = json['urlToImage'] as String;
    publishedAt = json['publishedAt'] as String;
    content = json['content'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (source != null) {
      data['source'] = source.toJson();
    }
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }

  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
}

class Source {
  Source({this.id, this.name});

  Source.fromJson(dynamic json) {
    id = json['id'] as String;
    name = json['name'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  String id;
  String name;
}
