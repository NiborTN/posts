import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';

abstract class PostLocalDataSource {
  ///Gets the cached [Model] which was gotten the last time the user had as internet connection
  ///
  ///Throws [CacheException] if no cached data is present
  Future<List<PostModel>> getLastPostList();
  Future<void> cachePostList(List<PostModel> postToCache);
}

// ignore: constant_identifier_names
const POST_LIST = 'CACHED_POST_LIST';

class PostLocalDataSourceImpl implements PostLocalDataSource {
  late SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cachePostList(List<PostModel> postToCache) {
    List<Map<String, dynamic>> jsonList = [];
    for (var i = 0; i < postToCache.length; i++) {
      jsonList.add(postToCache[i].toJson());
    }

    return sharedPreferences.setString(POST_LIST, jsonEncode(jsonList));
  }

  @override
  Future<List<PostModel>> getLastPostList() async {
    final jsonString = sharedPreferences.getString(POST_LIST);
    if (jsonString != null) {
      List<PostModel> postList = [];
      List jsonString2 = jsonDecode(jsonString);
      for (var i = 0; i < jsonString2.length; i++) {
        postList.add(PostModel.fromJson(jsonString2[i]));
      }
      // ignore: void_checks
      return Future.value(postList);
    } else {
      throw (CacheException());
    }
  }
}
