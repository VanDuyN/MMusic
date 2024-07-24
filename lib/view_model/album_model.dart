class AlbumModel {
  final String id;
  final String name;
  final List<String> song;
  final String title;
  final String image;
  final String idArtist;
  AlbumModel({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
    required this.song,
    required this.idArtist,
  });
  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['_id'],
      name: json['name'],
      title: json['title'],
      image: json['image'],
      song: List<String>.from(json['song']),
      idArtist: json['idAtrist']
    );
  }
}