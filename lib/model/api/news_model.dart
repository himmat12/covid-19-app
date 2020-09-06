class News {
  String title;
  String source;
  String summary;
  String url;
  String imageUrl;
  String createdAt;

  News.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        source = json['source'],
        summary = json['summary'],
        url = json['url'],
        imageUrl = json['image_url'],
        createdAt = json['created_at'];
}
