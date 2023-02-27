import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  /// calls the https://jsonplaceholder.typicode.com/ endpoint
  ///
  /// Throws a [ServerException] for all error codes
  ///
  Future<UserModel> getUser(userId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUser(userId) async {
    var url = Uri.https('jsonplaceholder.typicode.com', 'users/$userId');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
