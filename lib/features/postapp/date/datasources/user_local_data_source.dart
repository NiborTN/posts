import 'dart:convert';

import 'package:posts/features/postapp/date/datasources/user_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  ///Gets the cached [Model] which was gotten the last time the user had as internet connection
  ///
  ///Throws [CacheException] if no cached data is present
  Future<UserModel> getLastUserList();
  Future<void> cacheUserList(UserModel userToCache);
}

// ignore: constant_identifier_names
const CACHED_USER = 'CACHED_USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  late SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUserList(UserModel userToCache) {
    var jsonImage = userToCache.toJson();
    return sharedPreferences.setString(CACHED_USER, jsonEncode(jsonImage));
  }

  @override
  Future<UserModel> getLastUserList() {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw (CacheException());
    }
  }
}
