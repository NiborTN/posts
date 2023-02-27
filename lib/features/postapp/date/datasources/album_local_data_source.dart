import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/album_model.dart';

abstract class AlbumLocalDataSource {
  ///Gets the cached [Model] which was gotten the last time the user had as internet connection
  ///
  ///Throws [CacheException] if no cached data is present
  Future<List<AlbumModel>> getLastAlbumList();
  Future<void> cacheAlbumList(List<AlbumModel> albumToCache);
}

// ignore: constant_identifier_names
const ALBUM_LIST = 'CACHED_ALBUM_LIST';

class AlbumLocalDataSourceImpl implements AlbumLocalDataSource {
  late SharedPreferences sharedPreferences;

  AlbumLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAlbumList(List<AlbumModel> albumToCache) {
    List<Map<String, dynamic>> jsonList = [];
    for (var i = 0; i < albumToCache.length; i++) {
      jsonList.add(albumToCache[i].toJson());
    }

    return sharedPreferences.setString(ALBUM_LIST, jsonEncode(jsonList));
  }

  @override
  Future<List<AlbumModel>> getLastAlbumList() async {
    final jsonString = sharedPreferences.getString(ALBUM_LIST);
    if (jsonString != null) {
      List<AlbumModel> albumList = [];
      List jsonString2 = jsonDecode(jsonString);
      for (var i = 0; i < jsonString2.length; i++) {
        albumList.add(AlbumModel.fromJson(jsonString2[i]));
      }
      // ignore: void_checks
      return Future.value(albumList);
    } else {
      throw (CacheException());
    }
  }
}
