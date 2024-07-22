class CategoryModel {
  final String id;
  final String name;
  final String title;
  final String image;
  CategoryModel({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      name: json['name'],
      title: json['title'],
      image: json['image'],
    );
  }
}