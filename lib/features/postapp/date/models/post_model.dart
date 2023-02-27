import 'dart:convert';

import '../../domain/entities/posts.dart';

class PostModel extends Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body})
      : super(userId: userId, id: id, title: title, body: body);

  @override
  List<Object?> get props => [userId, id, title, body];

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }

  static Future<List<PostModel>> listPostModel(String response) {
    var body = jsonDecode(response);
    List<PostModel> list = [];
    for (var i = 0; i < body.length; i++) {
      list.add(PostModel.fromJson(body[i]));
    }
    return Future.value(list);
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }
}
