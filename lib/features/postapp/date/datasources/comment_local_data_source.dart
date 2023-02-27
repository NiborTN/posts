import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/comments_model.dart';

abstract class CommentLocalDataSource {
  ///Gets the cached [Model] which was gotten the last time the user had as internet connection
  ///
  ///Throws [CacheException] if no cached data is present

  Future<List<CommentsModel>> getLastCommentList();
  Future<void> cacheCommentList(List<CommentsModel> commentToCache);
}

// ignore: constant_identifier_names
const COMMENT_LIST = 'CACHED_COMMENT_LIST';

class CommentLocalDataSourceImpl implements CommentLocalDataSource {
  late SharedPreferences sharedPreferences;

  CommentLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCommentList(List<CommentsModel> commentToCache) {
    List<Map<String, dynamic>> jsonList = [];
    for (var i = 0; i < commentToCache.length; i++) {
      jsonList.add(commentToCache[i].toJson());
    }

    return sharedPreferences.setString(COMMENT_LIST, jsonEncode(jsonList));
  }

  @override
  Future<List<CommentsModel>> getLastCommentList() async {
    final jsonString = sharedPreferences.getString(COMMENT_LIST);
    if (jsonString != null) {
      List<CommentsModel> commentList = [];
      List jsonString2 = jsonDecode(jsonString);
      for (var i = 0; i < jsonString2.length; i++) {
        commentList.add(CommentsModel.fromJson(jsonString2[i]));
      }
      // ignore: void_checks
      return Future.value(commentList);
    } else {
      throw (CacheException());
    }
  }
}
