class InfoData {
  final String title;
  final String description;
  final String image;

  InfoData({
    required this.title,
    required this.description,
    required this.image,
  });

  factory InfoData.fromJson(Map<String, dynamic> json) {
    return InfoData(
      title: json['title'],
      description: json['description'],
      image: json['image_url'],
    );
  }
}
