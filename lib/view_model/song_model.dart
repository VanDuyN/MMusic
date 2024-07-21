import 'dart:convert';

class SongModel {
  final String id;
  final String name;
  final List<String> idArtist;
  final List<String> idCategory;
  final String song;
  final String image;
  SongModel({
    required this.id,
    required this.name,
    required this.idArtist,
    required this.idCategory,
    required this.song,
    required this.image,

  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['_id'],
      name: json['name'],
      idArtist: List<String>.from(json['idAtrist']),
      idCategory: List<String>.from(json['idCastegory']),
      song: json['song'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'idAtrist': idArtist,
      'idCastegory': idCategory,
      'song': song,
      'image': image,
    };
  }
}
