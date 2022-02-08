import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(0)
  Source source;
  @HiveField(1)
  String author;
  @HiveField(2)
  String title;
  @HiveField(3)
  String description;
  @HiveField(4)
  String url;
  @HiveField(5)
  String urlToImage;
  @HiveField(6)
  String publishedAt;

  static Box<Article> getArticleBox() => Hive.box<Article>('articles');

  Article(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt});

  Map<String, dynamic> toMap() => {
        'source': source.toMap(),
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
      };

  factory Article.fromMap(Map<dynamic, dynamic> map) => Article(
      source: Source.fromMap(map['source']),
      author: map['author'].toString(),
      title: map['title'].toString(),
      description: map['description'].toString(),
      url: map['url'].toString(),
      urlToImage: map['urlToImage'].toString(),
      publishedAt: map['publishedAt'].toString());
}

@HiveType(typeId: 1)
class Source extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  static Box<Source> getSourceBox() => Hive.box<Source>('sources');

  Source({required this.id, required this.name});

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  factory Source.fromMap(Map<dynamic, dynamic> map) =>
      Source(id: map['id'].toString(), name: map['name'].toString());
}
