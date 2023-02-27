import 'package:posts/features/postapp/domain/entities/user.dart';

class UserModel extends User {
  final int id;
  final String userName;

  const UserModel({
    required this.id,
    required this.userName,
  }) : super(id: id, userName: userName);

  @override
  List<Object?> get props => [id, userName];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['username'],
    );
  }

  List<Map<String, dynamic>> toJson() {
    return [
      {'id': id, 'userName': userName}
    ];
  }
}
