class Artist {
  final String id;
  final String name;
  final String title;
  final String image;
  Artist({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
  });
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['_id'],
      name: json['name'],
      title: json['title'],
      image: json['image'],
    );
  }
}
