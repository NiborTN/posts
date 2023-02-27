import 'package:equatable/equatable.dart';

class Comments extends Equatable {
  final int postId;
  final int id;
  final String name;
  final String body;

  const Comments(
      {required this.postId,
      required this.id,
      required this.name,
      required this.body});

  @override
  List<Object?> get props => [postId, id, body];
}
