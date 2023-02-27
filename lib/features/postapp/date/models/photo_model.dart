import 'dart:convert';

import '../../domain/entities/photo.dart';

class PhotoModel extends Photo {
  final int albumId;
  final int id;
  final String image;

  const PhotoModel(
      {required this.albumId, required this.id, required this.image})
      : super(albumId: albumId, id: id, image: image);

  @override
  List<Object> get props => [albumId, id, image];

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        albumId: json['albumId'], id: json['id'], image: json['url']);
  }

  static Future<List<PhotoModel>> listPhotoModel(String response) {
    var body = jsonDecode(response);
    List<PhotoModel> list = [];
    for (var i = 0; i < body.length; i++) {
      list.add(PhotoModel.fromJson(body[i]));
    }
    return Future.value(list);
  }

  Map<String, dynamic> toJson() {
    return {'albumId': albumId, 'id': id, 'image': image};
  }
}
