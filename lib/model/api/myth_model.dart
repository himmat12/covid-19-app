class Myth {
  String imageUrl;

  Myth.fromJson(Map<String, dynamic> json)
      : imageUrl = json['image_url'] == null ? null : json['image_url'];
}
