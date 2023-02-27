import 'package:equatable/equatable.dart';

import 'album.dart';
import 'posts.dart';

class User extends Equatable {
  final int id;
  final String userName;

  const User({
    required this.id,
    required this.userName,
  });

  @override
  List<Object?> get props => [id, userName];
}
