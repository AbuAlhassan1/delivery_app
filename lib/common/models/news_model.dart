import 'dart:convert';

NewsModel newsFromJson(String str) => NewsModel.fromJson(json.decode(str));
String newsToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  final int? totalCount;
  final List<NewsItem>? items;

  NewsModel({
    this.totalCount,
    this.items,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    totalCount: json["totalCount"],
    items: json["items"] == null ? [] : List<NewsItem>.from(json["items"]!.map((x) => NewsItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class NewsItem {
  final String? slug;
  final DateTime? publishDate;
  final List<ContentType>? categories;
  final String? title;
  final String? description;
  final dynamic keyword;
  final List<String>? images;
  final dynamic content;
  final ContentType? contentType;
  final String? language;
  final dynamic searchKeys;
  final List<dynamic>? tags;

  NewsItem({
    this.slug,
    this.publishDate,
    this.categories,
    this.title,
    this.description,
    this.keyword,
    this.images,
    this.content,
    this.contentType,
    this.language,
    this.searchKeys,
    this.tags,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) => NewsItem(
    slug: json["slug"],
    publishDate: json["publishDate"] == null ? null : DateTime.parse(json["publishDate"]),
    categories: json["categories"] == null ? [] : List<ContentType>.from(json["categories"]!.map((x) => ContentType.fromJson(x))),
    title: json["title"],
    description: json["description"],
    keyword: json["keyword"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    content: json["content"],
    contentType: json["contentType"] == null ? null : ContentType.fromJson(json["contentType"]),
    language: json["language"],
    searchKeys: json["searchKeys"],
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "publishDate": publishDate?.toIso8601String(),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "title": title,
    "description": description,
    "keyword": keyword,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "content": content,
    "contentType": contentType?.toJson(),
    "language": language,
    "searchKeys": searchKeys,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}

class ContentType {
  final String? slug;
  final String? name;

  ContentType({
    this.slug,
    this.name,
  });

  factory ContentType.fromJson(Map<String, dynamic> json) => ContentType(
    slug: json["slug"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "name": name,
  };
}
