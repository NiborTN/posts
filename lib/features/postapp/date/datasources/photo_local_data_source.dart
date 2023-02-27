import 'dart:convert';

import 'package:posts/features/postapp/date/datasources/photo_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/photo_model.dart';
import 'package:http/http.dart' as http;

abstract class PhotoLocalDataSource {
  ///Gets the cached [Model] which was gotten the last time the user had as internet connection
  ///
  ///Throws [CacheException] if no cached data is present

  Future<List<PhotoModel>> getLastPhotoList();
  Future<void> cachePhotoList(List<PhotoModel> photoToCache);
}

const PHOTO_LIST = 'CACHED_PHOTO_LIST';

class PhotoLocalDataSourceImpl implements PhotoLocalDataSource {
  late SharedPreferences sharedPreferences;

  PhotoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cachePhotoList(List<PhotoModel> photoToCache) {
    List<Map<String, dynamic>> jsonList = [];
    for (var i = 0; i < photoToCache.length; i++) {
      jsonList.add(photoToCache[i].toJson());
    }

    return sharedPreferences.setString(PHOTO_LIST, jsonEncode(jsonList));
  }

  @override
  Future<List<PhotoModel>> getLastPhotoList() async {
    final jsonString = sharedPreferences.getString(PHOTO_LIST);
    if (jsonString != null) {
      List<PhotoModel> photoList = [];
      List jsonString2 = jsonDecode(jsonString);
      for (var i = 0; i < jsonString2.length; i++) {
        photoList.add(PhotoModel.fromJson(jsonString2[i]));
      }
      // ignore: void_checks
      return Future.value(photoList);
    } else {
      throw (CacheException());
    }
  }
}
