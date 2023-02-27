import 'package:posts/core/error/exceptions.dart';

import '../models/album_model.dart';
import 'package:http/http.dart' as http;

abstract class AlbumRemoteDataSource {
  /// calls the https://jsonplaceholder.typicode.com/ endpoint
  ///
  /// Throws a [ServerException] for all error codes
  ///
  Future<List<AlbumModel>> getAlbumList();
}

class AlbumRemoteDataSourceImpl implements AlbumRemoteDataSource {
  final http.Client client;

  AlbumRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AlbumModel>> getAlbumList() async {
    var url = Uri.https('jsonplaceholder.typicode.com', 'albums');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return AlbumModel.listAlbumModel(response.body);
    } else {
      throw ServerException();
    }
  }
}
