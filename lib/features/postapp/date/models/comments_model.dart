import 'dart:convert';

import '../../domain/entities/comment.dart';

class CommentsModel extends Comments {
  final int postId;
  final int id;
  final String name;
  final String body;

  const CommentsModel(
      {required this.postId,
      required this.id,
      required this.name,
      required this.body})
      : super(postId: postId, id: id, name: name, body: body);

  @override
  List<Object> get props => [postId, id, body];

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return CommentsModel(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        body: json['body']);
  }

  static Future<List<CommentsModel>> listcommentsModel(String response) {
    var body = jsonDecode(response);
    List<CommentsModel> list = [];
    for (var i = 0; i < body.length; i++) {
      list.add(CommentsModel.fromJson(body[i]));
    }
    return Future.value(list);
  }

  Map<String, dynamic> toJson() {
    return {'postId': postId, 'id': id, 'body': body};
  }
}
