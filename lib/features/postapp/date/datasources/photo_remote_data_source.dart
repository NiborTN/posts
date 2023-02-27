import '../../../../core/error/exceptions.dart';
import 'post_remote_data_source.dart';

import '../models/photo_model.dart';
import '../models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PhotoRemoteDataSource {
  /// calls the https://jsonplaceholder.typicode.com/ endpoint
  ///
  /// Throws a [ServerException] for all error codes
  ///

  Future<List<PhotoModel>> getPhotoList(albumId);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final http.Client client;

  PhotoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PhotoModel>> getPhotoList(albumId) async {
    var url = Uri.https('jsonplaceholder.typicode.com', 'photos',
        {'albumId': albumId.toString()});
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return PhotoModel.listPhotoModel(response.body);
    } else {
      throw ServerException();
    }
  }
}
