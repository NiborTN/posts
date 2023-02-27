import 'dart:convert';

import 'package:posts/features/postapp/domain/entities/album.dart';

import '../../domain/entities/photo.dart';

class AlbumModel extends Album {
  final int userId;
  final int id;
  final String title;

  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  }) : super(userId: userId, id: id, title: title);

  @override
  List<Object?> get props => [userId, id, title];

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  static Future<List<AlbumModel>> listAlbumModel(String response) {
    var body = jsonDecode(response);
    List<AlbumModel> list = [];
    for (var i = 0; i < body.length; i++) {
      list.add(AlbumModel.fromJson(body[i]));
    }
    return Future.value(list);
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title};
  }
}
